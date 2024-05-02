import 'package:serinus/serinus.dart';
import 'package:serinus_config/serinus_config.dart';

class TestRoute extends Route {
  TestRoute({super.path = '/', super.method = HttpMethod.get});
}

class MainController extends Controller {
  MainController({super.path = '/'}) {
    on(TestRoute(), (context) async {
      final configService = context.use<ConfigService>();
      final value = configService.getOrThrow('TEST');
      return Response.text(value);
    });
  }
}

class MainModule extends Module {
  MainModule()
      : super(imports: [ConfigModule()], controllers: [MainController()]);
}

void main() async {
  final app = await serinus.createApplication(entrypoint: MainModule());

  await app.serve();
}
