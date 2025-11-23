import 'package:graduation_project/features/company_portal/domain/repositories/company_portal_repository.dart';
import 'package:graduation_project/features/company_portal/data/data_sources/company_portal_data_source.dart';



/// CompanyPortalRepositoryImpl is the concrete implementation of the CompanyPortalRepository
/// interface.
/// This class implements the methods defined in CompanyPortalRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class CompanyPortalRepositoryImpl implements CompanyPortalRepository {
      
   final CompanyPortalDataSource  companyPortalDataSource;
   CompanyPortalRepositoryImpl(this.companyPortalDataSource);
}