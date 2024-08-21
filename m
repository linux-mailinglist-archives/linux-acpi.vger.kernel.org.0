Return-Path: <linux-acpi+bounces-7752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A49593BB
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 06:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD0BB220B5
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 04:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271C015C155;
	Wed, 21 Aug 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6Ekxsem"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B3179A7;
	Wed, 21 Aug 2024 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216138; cv=fail; b=qcNVLq8cQNuB8eRcktza7xY2eOC/aCYIVkS59uqp+m6cwh0zM/0GPFz8vm4qBfh+xN+G2wQAsadaBazyXiNIpeMWn54rt+KTWxCtltuk5nZ0e9wqYTbfXTYvHwLw1y0VX6jLdvY7I9lS1gaKr0aE9im2vdukUq1CKRvTTavo5Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216138; c=relaxed/simple;
	bh=okqdFtPAbT4f4kuPHLDX+RCiBUGKkYxruxipZIn1Qm0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQefXOUzwEFVFIuF0mhE2/dtEDaaQlaDu2Xuf/YQcM4z+JGDNeV4gro8mDpGgfnuXmjD3oMykIUi3BLMoJHw1Gk7juwGz7InWPODmNh+rrfBFXZse3fnaPkTgbDRYmhJSD13CLPsZaiKrK19dw5ZnQ/5CPFTyi0SLwL7cGoCIBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6Ekxsem; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724216135; x=1755752135;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=okqdFtPAbT4f4kuPHLDX+RCiBUGKkYxruxipZIn1Qm0=;
  b=N6EkxsemhkvRrghF/8eY7N3LLoXtEqc5CjKHxyrv2KgBPrF3zP1tKzrD
   jXOhmjT3RcnHzwgrSGyVLCk+C936NLUNOBRKS+AcxsAPgOl5hSRRy3Zrc
   67I6TyKKTErR9Ia/IDfGsF6k+9oEyL5yMGtZVBBoWjXc15XX9HfPh9jXP
   UcXpcfTC3YXJ3EkG77dZ8QCMHorUFGX314D0UPKydvbIu7UMxJVS95ZdE
   cb48QnU6KDTwh3Zfx1wXpBxTzl+kWePXH4J4uZIwI7jejZj+Iz0n02SQL
   jndENi6xOR5qzC+3X2iN/UNv8H95FJFytTFegdzEbVc5fhwlzkIiELV/L
   Q==;
X-CSE-ConnectionGUID: N2ysw19IRwSRlHkqiLOq7w==
X-CSE-MsgGUID: 65A4KhtnSEeFegBQVJ31ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="45080399"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="45080399"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 21:55:35 -0700
X-CSE-ConnectionGUID: u3Zn4QDdR8qMwyFvI4hX5w==
X-CSE-MsgGUID: fNDTkxhDTH+VKL8zCQxPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61735092"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 21:55:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 21:55:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 21:55:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 21:55:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 21:55:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WawkAYpI4ESirAMcR2Eej+H+1NSra5hMjwrm8nWemNuaClL2RDDq6egNxYsS1IcKC9owhXigRnSiDWVe71OghwmClq37t83C5CvX7dXp7dN43oPuvu65b1MrLS8jHOozAjnSYMXNBYnN9En1c8LkUuVuol/HTbNrJejj4TheTl7T9jF3qVsoXS5GLf5HK5RNtcJvwPa78d0a1XamJDoU0QEbWW/w5UnrzRohmHx+YfWQ4ucWVO0YssCc5Tdkkx6xlxUbGAMHIR9suBF4F20kXoNQmTNMRlaD1abriIvshwtyIqyAv3XM6IiGbh5taef+4+dE4hZ9TAA0qYimHiVr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okqdFtPAbT4f4kuPHLDX+RCiBUGKkYxruxipZIn1Qm0=;
 b=N+FCb3fXBEPqgxXaVnYxxzaQnLg/dsYO2gA6GGujcEF0czOGEJGLEa1iASy5DAfuwat+cK2uwk8ofpcndtDZRxBmps5D/C9qIdd0oAOubP6Bhz+PFaAISwY+64OFgQ+3oWbmG5HXxihwET9ImX+3V2RBXaV3f+JdY3YT1iOpXQtMB+2AyOksu1mXv50O3nqJkQJIkEzB68QEE9lNAMMYCPXUx7ALnfcObLrKtmu2yDc1rA0kJlL2lgoBWeYq1Z3T8ij4V/k7hlFp7f4jTxHEd840aFTR9Qf2utBp6rgZA6NvxarCMFlV3yNtu8q+UZCsnSewR/NbKkvQPFwBol5HSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 04:55:25 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%4]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 04:55:25 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "mochs@nvidia.com" <mochs@nvidia.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "erik.kaneda@intel.com"
	<erik.kaneda@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Ko, Koba" <kobak@nvidia.com>
Subject: Re: [PATCH] acpi/prmt: find block with specific type
Thread-Topic: [PATCH] acpi/prmt: find block with specific type
Thread-Index: AQHa47zv/FjSqarIqkGArXguHN663bIxKsIAgAALQ4CAAA8qgA==
Date: Wed, 21 Aug 2024 04:55:25 +0000
Message-ID: <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
References: <20240801014853.1594699-1-kobak@nvidia.com>
	 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
	 <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
In-Reply-To: <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MW3PR11MB4588:EE_
x-ms-office365-filtering-correlation-id: e2eb4e56-7223-4e80-0fd7-08dcc19d7838
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QXRjeXpid012cFFlWCtKTk1iaFMyU3k1V1E3NmtjZkhzbWI3c3pqNEtZTTZT?=
 =?utf-8?B?TVByL1hremlWMWduTUlIT0txanRZWlVnL3Z6SzlESWlHWlh1R1lNYUxsY01l?=
 =?utf-8?B?UmNsUzkxRENuUGQvb2tlUVF6Q2Y3bTdJeWU1WmNVL2EzNldLTGZHbVo3aFdE?=
 =?utf-8?B?N1kwdjlmRGd1UUZITmNVY0NwRnlPc0lScVdMWDZEY1plcWVKWml3MFJqM21O?=
 =?utf-8?B?OEQrV0l1RGEzL3hmdVJ2ZzFHY1pXOUZkWVNzaHpaK0kvN2g3TUlSd2RPVlgx?=
 =?utf-8?B?UnExaTZ6YmQvMnNpbXNVR08wdE5tRllVNCtUNi9ub3ZNUGt1RUp2eFluRFow?=
 =?utf-8?B?RHRvNjRObndvVUdnQWZKOG5nbkZGNkQ3b29BY2h3M1FIZkFNdVVaRWtUL2dy?=
 =?utf-8?B?Vm1YMjdCVTYvcU0yUkZhTHpzSGhkZGxJV01iNUIvcnZweCs2ZU43Y3R4eEds?=
 =?utf-8?B?blJPTDBBY3dtUW8xbnVaVGpUc1J5M1JyeVpxY1lxdC9iNXFydHZOTElocDRu?=
 =?utf-8?B?cXd0MlZIT3NoT2QxS0R6bjc1ZGRHSUh1SEIwQUR5Yzc4SVE0ZFVkQ1E4clhF?=
 =?utf-8?B?azlNZFoyYlVjaEx5aWtmSGJMMnBTK0U5TXJLOUovV1NzSVEvZm1UdlI4aFRw?=
 =?utf-8?B?OW9xZ0duV0V5R3gyQitkOThFUklQUXc3UEtwbDBGSjEzM0xRTjl6RnBBSXA0?=
 =?utf-8?B?eTExTTVOcGhTWU80cUp3QmxSNlNNajNvdW9LLytybElqS0x3ZmQrWmgxbVVy?=
 =?utf-8?B?REsvdXViTWNvOGpNeWVKZDJJcnBkSnZsNTNHNjhTZGdaaTlnaDg1V0s5SnBr?=
 =?utf-8?B?OVRRdEZWMEF2QXF5NVNZaDgrSHNxYmNTNitobmVwQjFNazVKa3dKbjF3OVl0?=
 =?utf-8?B?YjRwL21FSGUzSG90Z0lENDRWMFFSS1NJQTIyVG54RGhZemhkQlh1L3dnSElm?=
 =?utf-8?B?QzhKekViakkwNC92RzhrOG5OQzUzazNaRGFkTXBuQ2NrVE1jdXRRWTliSGNF?=
 =?utf-8?B?M1cwZ0d3ZkZuMjlXMXJOdlROOS9pQ1Z3Smdtd3lKbnQ5eGRUdGNKZ1lLL2Ru?=
 =?utf-8?B?aTNiS2RqT0w3VjdXU1RVZTZtdlBHRGFaOWduVnRtWnpubVJCUmVDZnF5VEd2?=
 =?utf-8?B?amJBNmNmUDE2d1dVSGNNUnZwY256bEs3UTJYcVNzYnUzTXZoNWpvWCs1Mjhk?=
 =?utf-8?B?cEVOTFhibTBDZ1JBelhuZVRNemkxTDg2UXFFcGdOVHFnNHVrWGFkREIyZnlG?=
 =?utf-8?B?SVNuZjlPVlp4UzRTWXk2R2trUmNiN2dsa0U4MkFpUlB0aHQvemlyS1BrVnhO?=
 =?utf-8?B?OEdiZnJhdFhodEtTMTBVR2VoQlhxbi9FQllIWVpnZnpiWVAxWEdaWWlJWWNP?=
 =?utf-8?B?QkFtMUlzVXd0eGVBdUJCeDFIV09OS1Nodk54NkdKOGZIY3pNemhIa3E0RWlL?=
 =?utf-8?B?dTIvUlFrdkhIb25RMUo2RlpidzhhL0tIdGNUUWFxMmlLL04waDNHQmwyUTA3?=
 =?utf-8?B?L0xMN000c1BJbCtPb0x4clNJaXBRQXJULzF5WWZaVlBtYkpxeTkreFllZEds?=
 =?utf-8?B?eFNrTnVqeksyb1lrVjhSOWNkYVdRVTFPd0N4WUtaN0NrU0RsZllCb3BEYThG?=
 =?utf-8?B?d3ltR1NaZVhkM0d4ckx0U2dqeTlMZHAzZ1dlbDJUZ21FRmFIS1h1dzlOZGY2?=
 =?utf-8?B?TGpPQ2xwczhPcERibDlEbktWYzNHRXMrVWxLQVU2RHF5d3NxRmF6d084dmhB?=
 =?utf-8?B?akM3b25QM1JjOG4zTWhNeHlYSXc2cWNCMjhZZ29IS005cEx4NGtmTldhL25p?=
 =?utf-8?Q?vtuykci52NheirKU4hJS7hju8saUh6od+nlZc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHphdDdYK3UyRFpxY3F4RzN5VlBDV2tRWU5HcVVMalRPQW5lUEgwMDVEVEV6?=
 =?utf-8?B?ejZ5TndpK1Z5dTg1ei9RQVBNOFZMSUFBUEY2QkdZY1EwRGJOUTgvV3B0U0V5?=
 =?utf-8?B?OVl2djRmWXk3TVBPeS82cW9FVmh2cmRXMm04ZDBNUnF6L2lkZDRLTm5RQXg0?=
 =?utf-8?B?ME04WHpibmVpOWx4Yjc2WW93SWNlazdCQVZlcVBVMTI2TitLOFVNS0FsYVFq?=
 =?utf-8?B?Q04wdEIra3lrcnU2Z0U4U0s5NWplNE5BVldtWDZjdnd5VGh6cGJRN21tSXdJ?=
 =?utf-8?B?Q0hCb1lyeDMra001dDZXTU9oY0VtQnd6dUJ0Z3laS1hTYmNIbGVleGtwa0s4?=
 =?utf-8?B?UkNOc0VVL2tYd2dHelBhMHAwWG5RQWRTWEhBVU02RlhzTTR3eDExVWFHWk8z?=
 =?utf-8?B?L1AvTytDVk1TV2tieWtJMGYzNmp0MTZGREFPU251Ty90bjc0YjNPeTNFdGJ6?=
 =?utf-8?B?QlBUVGkzbm9HWG1xVmJua2sweFVJSGtvOTRENk5iRkVwTUxEdjJ0azhRdVV2?=
 =?utf-8?B?d0ZUdjdrWjJaanFnL2tTSFNlVlRNMVFVd3JGZTkzbkE0MmkyUklUQXpVR2ow?=
 =?utf-8?B?WGhCb3RiTGN5VDYrOHlnS2wwU2dVUWY1UHhjMHNWVnVuVlR1b1FQYklFWUQ2?=
 =?utf-8?B?Ny9LVXlCM1RHd1RLeXRXYmxGT0QreFJNdXJxNlNISnIzcFlhK3grbFBld2Y4?=
 =?utf-8?B?dmxxSmF6Y1ZiOWxCeWk0Y3RocER6ZWwrUlRMaEFiOGRCaE1CcklUdTQ2RXZv?=
 =?utf-8?B?LzNJaGw4RURpYmk2alhSN0w0M3ZuUGNuZTJ3UkZ4aEpNOXZQWVhaRlhmeHhI?=
 =?utf-8?B?WjhuTEhkQjZuSTNDSk1YQ3JLdW1WeW95YTIvdHo2alVxbVIzcW1VOXUrK0xE?=
 =?utf-8?B?cjF2TUtCSnlTTjBmamc5YUlJTVlTcFFhRWFLczVSdXBQdndNT0xPWGxlTTRH?=
 =?utf-8?B?T3JyeW9MdUZNRG1kU21wOGpMdFh2OXRDWTZSZEdJa1pzZlA4ZUJjOSs5ZVpM?=
 =?utf-8?B?bGxlUmlMY0NJeXpPUndGblJGMU0yTmNUbzAxRnE2MEdHMGxaMk44R20rOHdz?=
 =?utf-8?B?Mll5MVZPUGNGQ0habTFCbHc4U2UwelV0em1nN0ZuMGtPVDJEYVNkanZCK3Rr?=
 =?utf-8?B?UFh4UjE2U1JnQkl6SGw0emR5RnNtWm13aDRXWEJQUTZyTkpuM0tETFZ1NDNn?=
 =?utf-8?B?S3dzSk4yRS8zMHZ6U0lTRmdtY0RuT29OVEd5Q1ZWK1k3ZTZlMTFYSDZ5ZzM4?=
 =?utf-8?B?M0xMbG1RZk9sVnpHS2hubUVxbzd4S2tsc1FGdVlHK3VxVlVYMU1sQXVoTXZm?=
 =?utf-8?B?dFNJTzZXbk1CeGNGUGYzNXc0ZnVXTHJCcjNZb1VHSU9QZlBxaXdrOHFUT3Va?=
 =?utf-8?B?bTZscXdubk5KdDE5a29OdHdLaDUxR2pWZ2N5elNxUm9pV0ExLzFQeS95QlFN?=
 =?utf-8?B?aXl4bzV4K2RFRUJCMUpYTVNqamV5WkRqK3VkK3cvWE45MUhjeGFsRmljRXFY?=
 =?utf-8?B?S2xNdlpMRDdUWVRsdFlCNE9DRis5VXRFSk9nanpWNWRLU2wrRTEwdTl0aUla?=
 =?utf-8?B?MEYwVmlmQlkzbXVvNEo5Y3pLV3R6c1M3UndQdEJhMERkQWFlZFExU0lMa3Vz?=
 =?utf-8?B?akxmVDBrSTRuZW13Zlk1cGpzWGd6ckN1cklTNUNvZ0JYdVBia2RRMWVFenpN?=
 =?utf-8?B?VGFIbHRFaEN0WmE5cUZ3Qmo3NzZ4blZkUGZDMGZNdkdVQVNjZmJHcU1OdTJS?=
 =?utf-8?B?SGJPcStJeXVYNWp2YXM1ZDN3Sm81S3haV2Z3aDZ2UlZNVzRVdmtDZ3dyOHdp?=
 =?utf-8?B?bk9CZU9hSjdCTC9PMTFyejBtcWp6bzBBYmYreTd5cll0elJYZlFzbVd3Wng0?=
 =?utf-8?B?QWZlNDhzeHY4eWpoZHpVRmR0cWJtTWE2UVo5dml1SVladVdOL3VIRGZ2eXBy?=
 =?utf-8?B?MGpDQUFVc3cvZERuWlBodkYxU0ZSTDkvOUplSmtVQjhYT21pVElkUzlPOHkv?=
 =?utf-8?B?dUp4ZHBKY0JvL3RiNVNxcllhVmVHRDBtaWJvbkpXK3VjM2V4Yi9aMmdqbkJC?=
 =?utf-8?B?THNFVk1UYUxQOTRhQ09kQUk2ZEZJL1NzdGZGelNGazZ4TTNsVGQySmRJUzVt?=
 =?utf-8?B?T0NMNktrWkd2R0RHY2o2TXJEdkg1VGxZT0JodjZ1cGhET2JDTkRMb0FBZkhM?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD84C387D3299143952CCCA547E0E96F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eb4e56-7223-4e80-0fd7-08dcc19d7838
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 04:55:25.0681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dW4zfEwRu6FunyT9bn69m8rB8cWu8YT/JN8sIbJzTeBOIOrM3ooKGxFPvsxwvf9Q63DKw0qEZqnCNoPfxquV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEyOjAxICswODAwLCBLb2JhIEtvIHdyb3RlOgo+IE9uIDgv
MjEvMjQgMTE6MjAsIFpoYW5nLCBSdWkgd3JvdGU6Cj4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+ID4gCj4gPiAKPiA+IE9uIFRodSwg
MjAyNC0wOC0wMSBhdCAwOTo0OCArMDgwMCwgS29iYUsgd3JvdGU6Cj4gPiA+IFBSTVQgbmVlZHMg
dG8gZmluZCB0aGUgY29ycmVjdCB0eXBlIG9mIGJsb2NrIHRvCj4gPiA+IHRyYW5zbGF0ZSB0aGUg
UEEtVkEgbWFwcGluZyBmb3IgRUZJIHJ1bnRpbWUgc2VydmljZXMuCj4gPiA+IAo+ID4gPiBUaGUg
aXNzdWUgYXJpc2VzIGJlY2F1c2UgdGhlIFBSTVQgaXMgZmluZGluZyBhIGJsb2NrIG9mIHR5cGUK
PiA+ID4gRUZJX0NPTlZFTlRJT05BTF9NRU1PUlksCj4gPiA+IHdoaWNoIGlzIG5vdCBhcHByb3By
aWF0ZSBmb3IgcnVudGltZSBzZXJ2aWNlcyBhcyBkZXNjcmliZWQgaW4KPiA+ID4gU2VjdGlvbgo+
ID4gPiAyLjIuMiAoUnVudGltZQo+ID4gPiBTZXJ2aWNlcykgb2YgdGhlIFVFRkkgU3BlY2lmaWNh
dGlvbiBbMV0uIFNpbmNlIHRoZSBQUk0gaGFuZGxlciBpcwo+ID4gPiBhCj4gPiA+IHR5cGUgb2Yg
cnVudGltZQo+ID4gPiBzZXJ2aWNlLCB0aGlzIGNhdXNlcyBhbiBleGNlcHRpb24gd2hlbiB0aGUg
UFJNIGhhbmRsZXIgaXMgY2FsbGVkLgo+ID4gPiAKPiA+IFRvbyBtYW55IGNoYXJhY3RlcnMgaW4g
b25lIGxpbmUuCj4gPiBodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL3N1Ym1pdHRpbmct
cGF0Y2hlcy5odG1sI3RoZS1jYW5vbmljYWwtcGF0Y2gtZm9ybWF0Cj4gd2lsbCBmaXggdGhpcyBp
biB0aGUgZGVzY3JpcHRpb24uCj4gPiAKPiA+IAo+ID4gPiDCoMKgwqDCoCBbRmlybXdhcmUgQnVn
XTogVW5hYmxlIHRvIGhhbmRsZSBwYWdpbmcgcmVxdWVzdCBpbiBFRkkKPiA+ID4gcnVudGltZQo+
ID4gPiBzZXJ2aWNlCj4gPiA+IMKgwqDCoMKgIFdBUk5JTkc6IENQVTogMjIgUElEOiA0MzMwIGF0
IGRyaXZlcnMvZmlybXdhcmUvZWZpL3J1bnRpbWUtCj4gPiA+IHdyYXBwZXJzLmM6MzQxIF9fZWZp
X3F1ZXVlX3dvcmsrMHgxMWMvMHgxNzAKPiA+ID4gwqDCoMKgwqAgQ2FsbCB0cmFjZToKPiA+ID4g
wqDCoMKgwqDCoMKgIF9fZWZpX3F1ZXVlX3dvcmsrMHgxMWMvMHgxNzAKPiA+ID4gwqDCoMKgwqDC
oMKgIGVmaV9jYWxsX2FjcGlfcHJtX2hhbmRsZXIrMHg2OC8weGQwCj4gPiA+IMKgwqDCoMKgwqDC
oCBhY3BpX3BsYXRmb3JtcnRfc3BhY2VfaGFuZGxlcisweDE5OC8weDI1OAo+ID4gPiDCoMKgwqDC
oMKgwqAgYWNwaV9ldl9hZGRyZXNzX3NwYWNlX2Rpc3BhdGNoKzB4MTQ0LzB4Mzg4Cj4gPiA+IMKg
wqDCoMKgwqDCoCBhY3BpX2V4X2FjY2Vzc19yZWdpb24rMHg5Yy8weDExOAo+ID4gPiDCoMKgwqDC
oMKgwqAgYWNwaV9leF93cml0ZV9zZXJpYWxfYnVzKzB4YzQvMHgyMTgKPiA+ID4gwqDCoMKgwqDC
oMKgIGFjcGlfZXhfd3JpdGVfZGF0YV90b19maWVsZCsweDE2OC8weDIxOAo+ID4gPiDCoMKgwqDC
oMKgwqAgYWNwaV9leF9zdG9yZV9vYmplY3RfdG9fbm9kZSsweDFhOC8weDI1OAo+ID4gPiDCoMKg
wqDCoMKgwqAgYWNwaV9leF9zdG9yZSsweGVjLzB4MzMwCj4gPiA+IMKgwqDCoMKgwqDCoCBhY3Bp
X2V4X29wY29kZV8xQV8xVF8xUisweDE1Yy8weDYxOAo+ID4gPiDCoMKgwqDCoMKgwqAgYWNwaV9k
c19leGVjX2VuZF9vcCsweDI3NC8weDU0OAo+ID4gPiDCoMKgwqDCoMKgwqAgYWNwaV9wc19wYXJz
ZV9sb29wKzB4MTBjLzB4NmI4Cj4gPiA+IMKgwqDCoMKgwqDCoCBhY3BpX3BzX3BhcnNlX2FtbCsw
eDE0MC8weDNiMAo+ID4gPiDCoMKgwqDCoMKgwqAgYWNwaV9wc19leGVjdXRlX21ldGhvZCsweDEy
Yy8weDJhMAo+ID4gPiDCoMKgwqDCoMKgwqAgYWNwaV9uc19ldmFsdWF0ZSsweDIxMC8weDMxMAo+
ID4gPiDCoMKgwqDCoMKgwqAgYWNwaV9ldmFsdWF0ZV9vYmplY3QrMHgxNzgvMHgzNTgKPiA+ID4g
wqDCoMKgwqDCoMKgIGFjcGlfcHJvY193cml0ZSsweDFhOC8weDhhMCBbYWNwaV9jYWxsXQo+ID4g
PiDCoMKgwqDCoMKgwqAgcHJvY19yZWdfd3JpdGUrMHhjYy8weDE1MAo+ID4gPiDCoMKgwqDCoMKg
wqAgdmZzX3dyaXRlKzB4ZDgvMHgzODAKPiA+ID4gwqDCoMKgwqDCoMKgIGtzeXNfd3JpdGUrMHg3
MC8weDEyMAo+ID4gPiDCoMKgwqDCoMKgwqAgX19hcm02NF9zeXNfd3JpdGUrMHgyNC8weDQ4Cj4g
PiA+IMKgwqDCoMKgwqDCoCBpbnZva2Vfc3lzY2FsbC5jb25zdHByb3AuMCsweDgwLzB4ZjgKPiA+
ID4gwqDCoMKgwqDCoMKgIGRvX2VsMF9zdmMrMHg1MC8weDExMAo+ID4gPiDCoMKgwqDCoMKgwqAg
ZWwwX3N2YysweDQ4LzB4MWQwCj4gPiA+IMKgwqDCoMKgwqDCoCBlbDB0XzY0X3N5bmNfaGFuZGxl
cisweDE1Yy8weDE3OAo+ID4gPiDCoMKgwqDCoMKgwqAgZWwwdF82NF9zeW5jKzB4MWE4LzB4MWIw
Cj4gPiA+IAo+ID4gPiBGaW5kIGEgYmxvY2sgd2l0aCBzcGVjaWZpYyB0eXBlIHRvIGZpeCB0aGlz
Lgo+ID4gPiBwcm10IGZpbmQgYSBibG9jayB3aXRoIEVGSV9SVU5USU1FX1NFUlZJQ0VTX0RBVEEg
Zm9yIHBybSBoYW5kbGVyLgo+ID4gPiBwcm10IGZpbmQgYSBibG9jayB3aXRoIEVGSV9SVU5USU1F
X1NFUlZJQ0VTX0NPREUgZm9yIHBybSBjb250ZXh0Lgo+ID4gPiBCeSB1c2luZyB0aGUgY29ycmVj
dCBtZW1vcnkgdHlwZXMgZm9yIHJ1bnRpbWUgc2VydmljZXMsCj4gPiA+IHdlIGNhbiBlbnN1cmUg
dGhhdCB0aGUgUFJNIGhhbmRsZXIgYW5kCj4gPiA+IGl0cyBjb250ZXh0IGFyZSBwcm9wZXJseSBt
YXBwZWQgaW4gdGhlIHZpcnR1YWwgYWRkcmVzcyBzcGFjZQo+ID4gPiBkdXJpbmcKPiA+ID4gcnVu
dGltZSwKPiA+ID4gcHJldmVudGluZyB0aGUgcGFnaW5nIHJlcXVlc3QgZXJyb3IuCj4gPiBzb21l
IGdlbmVyYWwgcnVsZXMgdG8gZm9sbG93IHdoZW4gd3JpdGluZyBhIGNoYW5nZWxvZwo+ID4gaHR0
cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9tYWludGFpbmVyLXRpcC5odG1swqA0LjIuMy4K
PiA+IENoYW5nZWxvZwo+IHdpbGwgZGVjb3JhdGUgdGhpcy4KPiA+IAo+ID4gPiBbMV0KPiA+ID4g
aHR0cHM6Ly91ZWZpLm9yZy9zaXRlcy9kZWZhdWx0L2ZpbGVzL3Jlc291cmNlcy9VRUZJX1NwZWNf
Ml8xMF9BdWcyOS5wZGYKPiA+ID4gCj4gPiA+IEZpeGVzOiBjZWZjN2NhNDYyMzUgKCJBQ1BJOiBQ
Uk06IGltcGxlbWVudCBPcGVyYXRpb25SZWdpb24KPiA+ID4gaGFuZGxlcgo+ID4gPiBmb3IgdGhl
IFBsYXRmb3JtUnRNZWNoYW5pc20gc3VidHlwZSIpCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEtvYmFL
IDxrb2Jha0BudmlkaWEuY29tPgo+ID4gPiBSZXZpZXdlZC1ieTogTWF0dGhldyBSLiBPY2hzIDxt
b2Noc0BudmlkaWEuY29tPgo+ID4gPiAtLS0KPiA+ID4gwqAgZHJpdmVycy9hY3BpL3BybXQuYyB8
IDQ2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4gPiA+IC0tLS0tCj4g
PiA+IC0tCj4gPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxNSBkZWxl
dGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcHJtdC5jIGIv
ZHJpdmVycy9hY3BpL3BybXQuYwo+ID4gPiBpbmRleCBjNzg0NTNjNzRlZjUuLmUyZjBiZGQ4MTAx
MyAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9hY3BpL3BybXQuYwo+ID4gPiArKysgYi9kcml2
ZXJzL2FjcGkvcHJtdC5jCj4gPiA+IEBAIC03MiwxNyArNzIsMjEgQEAgc3RydWN0IHBybV9tb2R1
bGVfaW5mbyB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBybV9oYW5kbGVyX2luZm8g
aGFuZGxlcnNbXQo+ID4gPiBfX2NvdW50ZWRfYnkoaGFuZGxlcl9jb3VudCk7Cj4gPiA+IMKgIH07
Cj4gPiA+IAo+ID4gPiAtc3RhdGljIHU2NCBlZmlfcGFfdmFfbG9va3VwKHU2NCBwYSkKPiA+ID4g
K3N0YXRpYyB1NjQgZWZpX3BhX3ZhX2xvb2t1cCh1NjQgcGEsIHUzMiB0eXBlKQo+ID4gPiDCoCB7
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgZWZpX21lbW9yeV9kZXNjX3QgKm1kOwo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgIHU2NCBwYV9vZmZzZXQgPSBwYSAmIH5QQUdFX01BU0s7Cj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAgdTY0IHBhZ2UgPSBwYSAmIFBBR0VfTUFTSzsKPiA+ID4gCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAgZm9yX2VhY2hfZWZpX21lbW9yeV9kZXNjKG1kKSB7Cj4gPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtZC0+cGh5c19hZGRyIDwgcGEgJiYgcGEgPCBtZC0+
cGh5c19hZGRyICsKPiA+ID4gUEFHRV9TSVpFICogbWQtPm51bV9wYWdlcykKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKChtZC0+dHlwZSA9PSB0eXBlKSAmJgo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKG1kLT5waHlzX2Fk
ZHIgPCBwYSAmJiBwYSA8IG1kLT5waHlzX2FkZHIKPiA+ID4gKwo+ID4gPiBQQUdFX1NJWkUgKiBt
ZC0+bnVtX3BhZ2VzKSkgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHBhX29mZnNldCArIG1kLT52aXJ0X2FkZHIgKyBwYWdlCj4g
PiA+IC0gbWQtCj4gPiA+ID4gcGh5c19hZGRyOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiAKPiA+ID4gK8KgwqDCoMKg
wqDCoCBwcl9lcnIoIlBSTTogRmFpbGVkIHRvIGZpbmQgYSBibG9jayBmb3IgcGE6ICVseCB0eXBl
Cj4gPiA+ICV1XG4iLAo+ID4gPiBwYSwgdHlwZSk7Cj4gPiA+ICsKPiA+IElmIGl0IGlzIGEgcHJf
ZXJyLCB3aHkgbm90IGVycm9yIG91dD8KPiA+IG9yIHdoYXQgaXMgdGhlIHByb3BlciBoYW5kbGlu
ZyBmb3Igc3VjaCBmYWlsdXJlcz8KPiA+IApOb3Qgc3VyZSBpZiB5b3UgbWlzc2VkIHRoaXMgb25l
LgpJdCBpcyBub3QgY2xlYXIgd2hhdCBpcyB0aGUgZXhwZWN0ZWQgYmVoYXZpb3IgaW4gdGhpcyBj
YXNlLiBCZXR0ZXIgdG8KZGVzY3JpYmUgdGhpcyBpbiB0aGUgY2hhbmdlbG9nIGFzIHdlbGwuCgo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ID4gPiDCoCB9Cj4gPiA+IAo+ID4gPiBA
QCAtMTQ4LDkgKzE1MiwxMiBAQCBhY3BpX3BhcnNlX3BybXQodW5pb24gYWNwaV9zdWJ0YWJsZV9o
ZWFkZXJzCj4gPiA+ICpoZWFkZXIsIGNvbnN0IHVuc2lnbmVkIGxvbmcgZW5kKQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aCA9ICZ0bS0+aGFuZGxlcnNbY3VyX2hhbmRs
ZXJdOwo+ID4gPiAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3VpZF9j
b3B5KCZ0aC0+Z3VpZCwgKGd1aWRfdCAqKWhhbmRsZXJfaW5mby0KPiA+ID4gPiBoYW5kbGVyX2d1
aWQpOwo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aC0+aGFuZGxlcl9hZGRy
ID0gKHZvaWQKPiA+ID4gKillZmlfcGFfdmFfbG9va3VwKGhhbmRsZXJfaW5mby0+aGFuZGxlcl9h
ZGRyZXNzKTsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGgtPnN0YXRpY19k
YXRhX2J1ZmZlcl9hZGRyID0KPiA+ID4gZWZpX3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tPnN0
YXRpY19kYXRhX2J1ZmZlcl9hZGRyZXNzKTsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdGgtPmFjcGlfcGFyYW1fYnVmZmVyX2FkZHIgPQo+ID4gPiBlZmlfcGFfdmFfbG9va3Vw
KGhhbmRsZXJfaW5mby0+YWNwaV9wYXJhbV9idWZmZXJfYWRkcmVzcyk7Cj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoLT5oYW5kbGVyX2FkZHIgPQo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZvaWQgKillZmlfcGFfdmFfbG9v
a3VwKGhhbmRsZXJfaW5mby0KPiA+ID4gPiBoYW5kbGVyX2FkZHJlc3MsIEVGSV9SVU5USU1FX1NF
UlZJQ0VTX0NPREUpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aC0+c3Rh
dGljX2RhdGFfYnVmZmVyX2FkZHIgPQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZWZpX3BhX3ZhX2xvb2t1cChoYW5kbGVyX2luZm8tCj4gPiA+ID4g
c3RhdGljX2RhdGFfYnVmZmVyX2FkZHJlc3MsIEVGSV9SVU5USU1FX1NFUlZJQ0VTX0RBVEEpOwo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aC0+YWNwaV9wYXJhbV9idWZmZXJf
YWRkciA9Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlZmlfcGFfdmFfbG9va3VwKGhhbmRsZXJfaW5mby0KPiA+ID4gPiBhY3BpX3BhcmFtX2J1ZmZl
cl9hZGRyZXNzLCBFRklfUlVOVElNRV9TRVJWSUNFU19EQVRBKTsKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoCB9IHdoaWxlICgrK2N1cl9oYW5kbGVyIDwgdG0tPmhhbmRsZXJfY291bnQgJiYKPiA+ID4g
KGhhbmRsZXJfaW5mbyA9Cj4gPiA+IGdldF9uZXh0X2hhbmRsZXIoaGFuZGxlcl9pbmZvKSkpOwo+
ID4gPiAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPiA+ID4gQEAgLTI1MCw4ICsy
NTcsMTYgQEAgc3RhdGljIGFjcGlfc3RhdHVzCj4gPiA+IGFjcGlfcGxhdGZvcm1ydF9zcGFjZV9o
YW5kbGVyKHUzMiBmdW5jdGlvbiwKPiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGhhbmRsZXIgPSBmaW5kX3BybV9oYW5kbGVyKCZidWZmZXItCj4gPiA+ID5oYW5k
bGVyX2d1aWQpOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtb2R1bGUg
PSBmaW5kX3BybV9tb2R1bGUoJmJ1ZmZlci0+aGFuZGxlcl9ndWlkKTsKPiA+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFoYW5kbGVyIHx8ICFtb2R1bGUpCj4gPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGludmFsaWRfZ3Vp
ZDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFoYW5kbGVyIHx8ICFt
b2R1bGUpIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJ1ZmZlci0+cHJtX3N0YXR1cyA9Cj4gPiA+IFBSTV9IQU5ETEVSX0dVSURfTk9UX0ZPVU5E
Owo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBlcnJvcjsKPiA+IEkgdGhpbmsgaXQgaXMgb2theSB0byByZXR1cm4gQUVfT0sgZGlyZWN0bHks
IHJpZ2h0Pwo+ID4gCj4gPiB0aGFua3MsCj4gPiBydWkKPiAKPiBJJ20gYWxzbyBnb29kIGZvciB0
aGlzLgo+IEkgZm9sbG93ZWQgdGhlIGNvbnZlbnRpb24gaW4gdGhpcyBibG9jay4KPiBJZiBjaGFu
Z2UgdG8gInJldHVybiIsIGkgd2lsbCBjaGFuZ2UgYWxsICJnb3RvIGVycm9yIi4KPiBIb3cgZG8g
eW91IHRoaW5rPwoKc291bmRzIGdvb2QgdG8gbWUuCgotcnVpCgo+IAo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFoYW5kbGVyLT5oYW5kbGVyX2FkZHIgfHwgIWhhbmRsZXItCj4gPiA+ID4g
c3RhdGljX2RhdGFfYnVmZmVyX2FkZHIgfHwKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICFoYW5kbGVyLT5hY3BpX3BhcmFtX2J1ZmZlcl9hZGRyKSB7
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWZm
ZXItPnBybV9zdGF0dXMgPSBQUk1fSEFORExFUl9FUlJPUjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyb3I7Cj4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ID4gCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEFDUElfQ09QWV9OQU1FU0VHKGNvbnRleHQuc2lnbmF0dXJlLCAiUFJNQyIp
Owo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250ZXh0LnJldmlzaW9u
ID0gMHgwOwo+ID4gPiBAQCAtMjc0LDggKzI4OSwxMCBAQCBzdGF0aWMgYWNwaV9zdGF0dXMKPiA+
ID4gYWNwaV9wbGF0Zm9ybXJ0X3NwYWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgIGNhc2UgUFJNX0NNRF9TVEFSVF9UUkFOU0FDVElPTjoKPiA+ID4gCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1vZHVsZSA9IGZpbmRfcHJtX21vZHVs
ZSgmYnVmZmVyLT5oYW5kbGVyX2d1aWQpOwo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoIW1vZHVsZSkKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gaW52YWxpZF9ndWlkOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIW1vZHVsZSkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZmVyLT5wcm1fc3RhdHVzID0KPiA+ID4gUFJNX0hBTkRM
RVJfR1VJRF9OT1RfRk9VTkQ7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4gPiA+IAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
bW9kdWxlLT51cGRhdGFibGUpCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtb2R1bGUtPnVwZGF0YWJsZSA9IGZhbHNlOwo+ID4gPiBAQCAtMjg2
LDggKzMwMywxMCBAQCBzdGF0aWMgYWNwaV9zdGF0dXMKPiA+ID4gYWNwaV9wbGF0Zm9ybXJ0X3Nw
YWNlX2hhbmRsZXIodTMyIGZ1bmN0aW9uLAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUFJN
X0NNRF9FTkRfVFJBTlNBQ1RJT046Cj4gPiA+IAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtb2R1bGUgPSBmaW5kX3BybV9tb2R1bGUoJmJ1ZmZlci0+aGFuZGxlcl9ndWlk
KTsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFtb2R1bGUpCj4gPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGludmFs
aWRfZ3VpZDsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFtb2R1bGUp
IHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1
ZmZlci0+cHJtX3N0YXR1cyA9Cj4gPiA+IFBSTV9IQU5ETEVSX0dVSURfTk9UX0ZPVU5EOwo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJv
cjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiAKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1vZHVsZS0+dXBkYXRhYmxlKQo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnVmZmVy
LT5wcm1fc3RhdHVzID0KPiA+ID4gVVBEQVRFX1VOTE9DS19XSVRIT1VUX0xPQ0s7Cj4gPiA+IEBA
IC0zMDEsMTAgKzMyMCw3IEBAIHN0YXRpYyBhY3BpX3N0YXR1cwo+ID4gPiBhY3BpX3BsYXRmb3Jt
cnRfc3BhY2VfaGFuZGxlcih1MzIgZnVuY3Rpb24sCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ID4gCj4gPiA+
IC3CoMKgwqDCoMKgwqAgcmV0dXJuIEFFX09LOwo+ID4gPiAtCj4gPiA+IC1pbnZhbGlkX2d1aWQ6
Cj4gPiA+IC3CoMKgwqDCoMKgwqAgYnVmZmVyLT5wcm1fc3RhdHVzID0gUFJNX0hBTkRMRVJfR1VJ
RF9OT1RfRk9VTkQ7Cj4gPiA+ICtlcnJvcjoKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
QUVfT0s7Cj4gPiA+IMKgIH0KPiA+ID4gCj4gCgo=

