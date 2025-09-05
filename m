Return-Path: <linux-acpi+bounces-16434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50CB46407
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7509166E04
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434A28136C;
	Fri,  5 Sep 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fy50gajr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4552E55A
	for <linux-acpi@vger.kernel.org>; Fri,  5 Sep 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102316; cv=fail; b=YLTksd3QEaKADrenB275K6rHYFh/0FaoN5HwuT8jzCEsZ7Fy9n0LvpA3LfRnKUS2qaKtjOZ99XKlYAcBvXz0tUO0y6qyuG/3P3XO90NmLQS8kEYxW+2QnDbHIQ+SRvNnrhbhI0ekj1iWH7NRdqTE2Bg+3CPAjuQy0qXoD5++Ss0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102316; c=relaxed/simple;
	bh=oQLt3N/o6OfdGLxdjAOcFTa5WOxAxFqYt2QiQ9Blib8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krUoY4t7I01ipPBO7SzCzwGFVDzd+jLsut8WgD4mlpRwoPOg3XjG3W+e0MnoRsdI9zYfepo9N8/+CSvfa4k6yi0A8yNURqDku9DQ1aU8Qg4Wc4RCPnI/Xz3tVslwapO2Ui+nSVaW8T0O/L/swx2qMD8EHBy3W7L1tdVZ4yQkmcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fy50gajr; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757102315; x=1788638315;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oQLt3N/o6OfdGLxdjAOcFTa5WOxAxFqYt2QiQ9Blib8=;
  b=fy50gajrfaJo3FYMZS+a6qVLCRV5I6vwgaHb/wavcqpOi+gE5+9AmAdL
   5JKgb0ziwSYaSZVGCzhZHjBp20VKTvtMMmHX+mLznhalwh5B9pk6EzW9r
   QETBL0g3nPrgIf36cdmHRupJf8qaZ6CBHP+7NxXr5eHtwSvoNtYM9AXsR
   uepVGUGcsznr6sQX8BL6xBgwuvfT4IyJ3MgJ823CW2mAIHxnETa/jIFIW
   uaHIjFHYuBU/h6ulfuhRJs/9/m0s9sWXdPhObajWMHuHL+iSD15QoK646
   3ciCi9tVgTYEPgS7wUjCX14OnEK1o/Coq+pAZTW3dBQRDEHdJuuzAJXoe
   g==;
X-CSE-ConnectionGUID: ++b4IIIESf+PWRtyi3Kpiw==
X-CSE-MsgGUID: PebxqTBGTmaUmOIwa9Uxig==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="47027209"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="47027209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 12:58:33 -0700
X-CSE-ConnectionGUID: ld4QZt3aQWyZyR6OtCk/kg==
X-CSE-MsgGUID: T0MQwqg+T6KlF5TfM/S0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="195905382"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 12:58:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 12:58:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 12:58:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 12:58:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeagPpLld8hjT7hc7yp0B1G5uLNnXCMCHYNSE153ctz/+YVmnXJQPv4bUZOJEuGHDufWWJQjEBV8Z1FIAVmmFphdnQlRQmtYw9ONEfwDvEj9SFyjk2hEsa9wA5dEqDTWWpIpBEeWfVi2ecwkdleT+JV5hhtCiTOPmxCFTvUXVXZR8nqyRA933u04MoJa4awBsLbZWIIEQvNV/4IpPCqs5HJks/8D+X8h4OUM/wbf77FPtOAlCudGPNbrWzy/3uDqQ/ZTGwWOTGV0ctiFXQqnOXxX7rUUO5VtOAqMSkAxFuQd8QiMoCtVGe+rFyHHV13/tH8Wz2b6+MMvxeN6NW1GIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQLt3N/o6OfdGLxdjAOcFTa5WOxAxFqYt2QiQ9Blib8=;
 b=IjHQaKQXWpdbXP86ilWabkE4u2SJjcGYC8KB1hn87kTDepMOXzdoP717sH9S7U5gfE/yQe0EdvnuP/R2Ry80cbOH72wXdnVr2b/+jfL+M7KTPoTmF7dJXv/WVUlmcZiNvL+p9ekdhukBwd6F/OQwrL5vNtnu/IU3nlE08psWsXOk1jPZYPsezOW1xkydfSbHRt0TjBF4fJXQnTtZqQUkAFzpDVkBbGNoieenu1oU/7wW/e/ZXAxpgmO8tjRdQwAsrlFfHRijG8SSfH66eisRSoPASiZOIq1a+bFicO7yalheLShpkpZmITihvIqN5Sg+H6ma8qjQLJqNqDVsTJSt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 19:58:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 19:58:19 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "jane.chu@oracle.com" <jane.chu@oracle.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"surenb@google.com" <surenb@google.com>, "Anderson, Russ"
	<russ.anderson@hpe.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "nao.horiguchi@gmail.com"
	<nao.horiguchi@gmail.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "jiaqiyan@google.com"
	<jiaqiyan@google.com>, "david@redhat.com" <david@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "Meyer, Kyle" <kyle.meyer@hpe.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Fan, Shawn"
	<shawn.fan@intel.com>
Subject: RE: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Thread-Topic: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
Thread-Index: AQHcHpFNghz0HBmU602rHD1MDcKklLSE/FYAgAAC9JA=
Date: Fri, 5 Sep 2025 19:58:19 +0000
Message-ID: <SJ1PR11MB60830CB47549119351B1DF73FC03A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
 <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
In-Reply-To: <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4881:EE_
x-ms-office365-filtering-correlation-id: d2330fd9-e58c-49ee-2d99-08ddecb68f89
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ek8yMVVIY1NiaVorRnJsdEpoUk9wTTBKMktIeVlKR3Q0QU9nTUdVSGdoN3M1?=
 =?utf-8?B?SEFITUlDbWJGK1pmdFJvZGxCRWgxMGhDWlpJMGxGYzhvQUMvNktZS3BXQVlY?=
 =?utf-8?B?bHk1b0FUOWliNHZFcVRpSDRnN3JQbHYxckFFc1JHd3hPWDRZc1A4cGpoeFZY?=
 =?utf-8?B?MWN6VzNoaXdYOU9LeUJYK3JDSldGRXlvVlN5QlBObU9ESkVJNmJWMTE0R0Nj?=
 =?utf-8?B?Qk1aUFgzdStxdGJ1YmI1dFYwU1Q4S254RFd3T1JLNjF4QUYxemtWS2RkZGtn?=
 =?utf-8?B?eHExMk9GT2grSFZ5VDlCNEFSUDNnUmNrcGRsQ0tlZVJpMUVOMjFGNkxucGZ1?=
 =?utf-8?B?RjVValRQbnUyTDNuT2RzOFRaVXZXc0ZyT1F2NWRJUDFqUENUS2tiTnlROWln?=
 =?utf-8?B?eml6M1VqRU9Ea2tYb0l4ZkFhUFJnS2N4b3JENGsyRDJpTDR3bGpxRFlwVXYr?=
 =?utf-8?B?YzdxRWpCc3pqQmhyRWNyREVLMzN2M1YzNytVMGh1bWNIbXQ1cytSTUwyanFQ?=
 =?utf-8?B?UG5mSTRqbTJrNzJKcXpkcnh3RDJleE5kdFoxNE02YndzK3FlL2Q0M25pMHZ3?=
 =?utf-8?B?ZzFKTEZ4R01GajF2b1JvdU5TT1JNWmpMYzRXaWZ0aUVZNy9CTFhxZmxkYklu?=
 =?utf-8?B?RGViQy9yNVJBckVEaWwvdUVmWmoyWWVuNXE4c0h2bHYyNTJid3QvZk16N2wz?=
 =?utf-8?B?dmt3RWI0bzN4QWR4L1U0YU1MVEswQXBpMjBabUs0cW1jbXNLNHdQdXdENThx?=
 =?utf-8?B?YVZIdmNUMkdoandaWjhFeElTU0JWUmpXUnFBM0RiWDU0MUdwSEd3U2xlalls?=
 =?utf-8?B?dnJZZUNoK3dIUWp5TTdDeVpSdzlNY2g5UlhTNDExZm14TUlENW5VL3ZoS2dR?=
 =?utf-8?B?N2U5bnJDb0pHQTl0NFR0ZHp0T21pN2ViZElLTm1YOTlCMXZVY205dkYyMnhT?=
 =?utf-8?B?K203OUpmaG8rNUNPazNWSE8wbklDRUhDM0Z5YXJPZTJzWU1rMVdOUU5sc0t4?=
 =?utf-8?B?ZFNwY0dSb1UxK0YyNkRMOVJwU0duYmR6NWoxSUtOTWR4cWpURjdjcjl4R01G?=
 =?utf-8?B?S2g0OE10dVp4OWVKZnNqOFQ1VExNYVNrZSthbUEyRTVqMmZpUHl4b0xWcUZp?=
 =?utf-8?B?MTBmaVRVU1JWQkc5S0xGNkVtWS9HbW9zbUhTZXRFSFo2RDZpOE9MRlZ0aW90?=
 =?utf-8?B?MXdJRXdDbXUrNW9LMzJkTHhJczhLTUxrbEhWMjU0R1JEQUlOVVJQS1VTYzBv?=
 =?utf-8?B?Q0Jjckx3akY0UWg1bGFJUWhXNHVTejRydkJwQnVsandzZjhxOVQwV3M0c1cw?=
 =?utf-8?B?UDhWMmFRdFlZQzFUeHBwcUZvVWtNN2FGZE5mRm5kdHhLQnByUmp3ZmJRSnhP?=
 =?utf-8?B?cmpIUkQwMmJNNTNSTlJibEhZVVgwaXl5QndOSWFlWjRTcHFIbnlsRFR5cUhO?=
 =?utf-8?B?RS90WDdmUDA0bEV4bitZbFZkNHZCcXhHbDNiYk96emgwaDA4ZHVNTW04blB4?=
 =?utf-8?B?K0NqYk1IeGdYZFdoOXRRMzlJMFdaQmdZS205alIyQWVKUjZVdGs2THd6Q04v?=
 =?utf-8?B?RXRHM3FKWFZ1RTlBV1F4bGRxbFJZZGZ6dDFXWjdISDNUMjNmUmdZMFhJMkxQ?=
 =?utf-8?B?Z09uUFI3NGZicVVrdEo5V2hySERWVW9Da1RoYW5lcm1iUTJlem1RVGdsNDZy?=
 =?utf-8?B?cGdJNlhBQUFkb0lHUE9nNDkvRFBxNSt3c2xNdU5XRUpuNGtjME5XZDRoNm4x?=
 =?utf-8?B?YzgrMkdPS0hKa3JNUDlleUMvS3NFa2pyajB6d2hsRHVtTWo4QkM0ZEFKWTcr?=
 =?utf-8?B?WWhTN3R2Sm52dk80d0I2aDJBbXkvTGFNSGhWSGRTbmNPSHRoKzQzbmVtbHlk?=
 =?utf-8?B?M0dXUjU1RVdFbHUvYmx4cnlzeXlTVmhiZXI0OEFlWTBKRzg2ajNQbmRqVlB3?=
 =?utf-8?B?eEZuSGFRemtFL3g2eXFRNytSeDRiMEJLWlJZWnIrOGNXMUVtOGNFRkJhUDUy?=
 =?utf-8?Q?03+PaelRlxRcMtGoHfkjefTpqAIMSM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3FMUktJT3F5WHl5WFA1WmM0QnE4eHNGMGtBWWZPelpUSEYrQWVHUTNqWlFa?=
 =?utf-8?B?L2cySzFJNWU2Lzh3Ly9hb1FyRTh1bS9JYmgwaTRLWVFJeXdqZUllVytyODNV?=
 =?utf-8?B?UzNWeSsrVjF3bG9PNXZ5enpoOSthMzNuVzBsa0tkWkpiRlN4R1QyMG1LY09t?=
 =?utf-8?B?eitoV0VwOWVKT1R2YW1KZ2VXYXVHek4zMGhTZmxEMUlIZW5oZUsvR29JeG5s?=
 =?utf-8?B?elJRMU81citkZWZXNGVQNXA4Z1FGcytMN1ZSN1JWZDMvZS92TU5wRFJkY0xr?=
 =?utf-8?B?YWFCQUVBZ0JjVzY2cFlicDdBZk9ZTDVTbzhDYWRnV2JuaTgvLzdqVWdvWjlH?=
 =?utf-8?B?YXR0Vi9NelExV2hxWXVaL1h3SmE2bU5Nb21qd1JWZmJVNHJ4WTBIa2NRNVlj?=
 =?utf-8?B?STBMSEhOMXd1RnRHTm5ucUNzWG5mWWhtV3ZzZG8zaVg0SXlmNFBlaitURWQ5?=
 =?utf-8?B?dVBnSm9YWisvSmNJYlhIOGN0bjZaRXJKbGg2Tm84cStBaVdMNWVkQXEwQTBV?=
 =?utf-8?B?c0R0ZkUvMVlncEw4K3doeXlZMDM4Ykwwakc0T1ZlaVN3T1BMaXF2UE1VdndQ?=
 =?utf-8?B?LzJDNy8xMHZ0dUdnWGRwTDVRQ3FQaUVodXNMRXVnRUFrOUhLc3hFZVZXV3BR?=
 =?utf-8?B?dFNwdi9Yalo1Z2VFRHJ5QnBacGF0ZENhK1BZNTNFMG03ZkF2SlJyeVZCVm85?=
 =?utf-8?B?bVN4a25mNjVHLzBkYTNhL3cwSEQ3R1NSZm5ibW1RNGFzZ0paNzNMc3hadE9W?=
 =?utf-8?B?Rzc3bzcvM2Q4YkEzd0JvNUV3TXZmMEJuY3o1b3VucEVMUnZ2dlg2TVBSMXlQ?=
 =?utf-8?B?bTUxTkVxdEE2TVhwUzdYUStrVVFsTkFwaGJlc28wbXJPTE9oNzl1c1prOStm?=
 =?utf-8?B?aU11ellaeFNpNS94T1ZNdXREbFdBQVdSOHZlQmpxWnhHMHpOWDBUeXB3ZENu?=
 =?utf-8?B?Tko4b2tHb3lUcUM5YUN0NTJHd1ZldXBBNU1xOE9ZZEVtbXFGQWx0M3h0K0Vy?=
 =?utf-8?B?NUpiTldpeXQyem9qajNLNVFjWCtYS1VVWVlETFBUd1pkTXM3N1hQYWlhL0xl?=
 =?utf-8?B?c1I4Qkg4YUhnbDB6cm1KNk1ZbVU3RGhMczRCNkRFZUZ1WmpxLzMyL0NhOFlW?=
 =?utf-8?B?KzIyK0dNR2FPeGUxaHovQXJoOUNlSkdSdUxReDlieHE5ZG5lV3djNWtBTGhq?=
 =?utf-8?B?NFlJQ2RvWDRpdW9mOTJadnZXR09YTTk4MWp6QnhkVmFXTWlBWDhDT1VZOXZl?=
 =?utf-8?B?N1pOVzJmWmxQNERjWlpMY1NVUlhRSSt3RFRwYk5CbXg1MlhmKzZJNHQ1dGt3?=
 =?utf-8?B?TDl1RVFXOEp2YlRvTjFhU3RWc2JOV0QralcwS2ZvLzhYOUFzYzVyM0RmeEU2?=
 =?utf-8?B?cnBkZnI5TTFIQmRCUE85VXA1R2IveUZSRkNIRnRQSHppd1dVT1MwdXhMODB2?=
 =?utf-8?B?MzNkUGY1ZGYvTm4vb3dDS3A1Yi9YREM4WFdXb3FDTlY4aFkzbVdJWHZmTVl1?=
 =?utf-8?B?WFJkaVBoZExYV3NEdFowMHgwL3JBNXNCNEFEbnh6M3RnSml2dCtmcUZPbnFD?=
 =?utf-8?B?NzlNeHVmQU1BTUNld0REbXp4Tm1Pd1FyQ2JST29vd0x3UG51bVcvanVzMWdx?=
 =?utf-8?B?L2F2TVZuUFl4WUdBTDBWRFRsMWo2aTBQbDY1YjIzZVdVc05sbXNZcGh1Y3pT?=
 =?utf-8?B?elJWa25zRVFWNkU5REp3OEZHYzV3VUMxZ2g5QzJUOWFmQ1J6NVZ0NjNWVkNB?=
 =?utf-8?B?dlg3YmxtVE41S2o3dzRkT3ZnaSt1ci9PbHM5T3hldTlBdEhLNlpJdUtmUXlW?=
 =?utf-8?B?Z3ZQYXo1ZzBqbWFoY3JhVmJlaHZqSldEamYydUh3dVVpdXo2RW1lNUJMUGRT?=
 =?utf-8?B?dlJtMGxpSkt2dHRNemxqeFlnZVRZWXVwVi90QVhibXVaVmgvMGRnRWJsTlZF?=
 =?utf-8?B?azQrMzZrZnhheHdzRmpLQit1U05Pa1EzeWlJa2ZYekNxdUtGYUE2cTVMZ00r?=
 =?utf-8?B?UHdkRmNEWGhzMWpsd0k3TFBwU2RudjlmWHJ5cDBhclU0dXNmcXVFd0Q2cVNy?=
 =?utf-8?B?TlZkcDlmUENNRDZsSmd5RXAvNGhvcjAvejMzLzRjRTFHVzZEbWJrZ1FrSHpW?=
 =?utf-8?Q?fce0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2330fd9-e58c-49ee-2d99-08ddecb68f89
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 19:58:19.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpnAExxtcT8mHuqO4svPgT/hJVIJt8uiEYk6SlR8sgVFdCw+ODXC7u+xMWmCUDUNop/QEfGDctan4sT5Kme5Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com

PiBTbyB0aGUgaXNzdWUgaXMgdGhlIHJlc3VsdCBvZiBpbmFjY3VyYXRlIE1DQSByZWNvcmQgYWJv
dXQgcGVyIHJhbmsgQ0UNCj4gdGhyZXNob2xkIGJlaW5nIGNyb3NzZWQuIElmIE9TIG9mZmxpbmUg
dGhlIGluZGljdGVkIHBhZ2UsIGl0IG1pZ2h0IGJlDQo+IHNpZ25hbGVkIHRvIG9mZmxpbmUgYW5v
dGhlciA0SyBwYWdlIGluIHRoZSBzYW1lIHJhbmsgdXBvbiBhY2Nlc3MuDQoNCkl0IGFwcGVhcnMg
dGhhdCB0aGUgQklPUyB0aGF0IHJlc3VsdGVkIGluIHRoaXMgcmVwb3J0IHNlbnNpYmx5IHRyZWF0
cyBjcm9zc2luZw0KdGhlIHJhbmsgZXJyb3IgdGhyZXNob2xkIGFzIG5lZWRpbmcgYSBvbmUtdGlt
ZSByZXBvcnQgdmlhIEdIRVMuDQoNCj4gQm90aCBNQ0EgYW5kIG9mZmxpbmUtb3AgYXJlIHBlcmZv
cm1hbmNlIGhpdHRlciwgYW5kIGFzIGFyZ3VlZCBieSB0aGlzDQo+IHBhdGNoLCBvZmZsaW5lIGRv
ZXNuJ3QgaGVscCBleGNlcHQgbG9vc2luZyBhIGFscmVhZHkgY29ycmVjdGVkIHBhZ2UuDQo+DQo+
IEhlcmUgd2UgY2hvb3NlIHRvIGJ5cGFzcyBodWdldGxiIHBhZ2Ugc2ltcGx5IGJlY2F1c2UgaXQn
cyBodWdlLiAgSXMgaXQNCj4gcG9zc2libGUgdG8gYXJndWUgdGhhdCBiZWNhdXNlIHRoZSBwYWdl
IGlzIGh1Z2UsIGl0J3MgbGVzcyBsaWtlbHkgdG8gZ2V0DQo+IGFub3RoZXIgTUNBIG9uIGFub3Ro
ZXIgcGFnZSBmcm9tIHRoZSBzYW1lIHJhbms/DQoNCklmIHRoZXJlIHJlYWxseSBpcyBhIHByb2Js
ZW0gd2l0aCB0aGUgcmFuaywgaXQgbGlrZWx5IGFmZmVjdHMgbW9zdCBwYWdlcyAob3INCmF0IGxl
YXN0IG1vc3QgcGFnZXMgb24gdGhlIHNhbWUgTlVNQSBub2RlKSBiZWNhdXNlIG1lbW9yeSBhY2Nl
c3MNCmlzICh1c3VhbGx5KSBpbnRlcmxlYXZlZCBiZXR3ZWVuIGNoYW5uZWxzLCBhbmQgYWNjZXNz
ZXMgd2l0aGluIGEgNEsgcGFnZQ0KbWF5IGhhc2ggdG8gZGlmZmVyZW50IHJhbmtzIHdpdGhpbmcg
YSBjaGFubmVsLg0KDQo+IEEgd2hpbGUgYmFjayB0aGlzIHBhdGNoDQo+IDU2Mzc0NDMwYzVkZmMg
bW0vbWVtb3J5LWZhaWx1cmU6IHVzZXJzcGFjZSBjb250cm9scyBzb2Z0LW9mZmxpbmluZyBwYWdl
cw0KPiBoYXMgcHJvdmlkZWQgdXNlcnNwYWNlIGNvbnRyb2wgb3ZlciB3aGV0aGVyIHRvIHNvZnQg
b2ZmbGluZSwgY291bGQgaXQgYmUNCj4gYSBtb3JlIHByZWZlcmFibGUgb3B0aW9uPw0KDQpUaGFu
a3MgZm9yIHBvaW50aW5nIHRoYXQgb25lIG91dC4gSSdsbCBmZWVkIHRoYXQgYmFjayB0byB0aGUg
b3JpZ2luYWwgcmVwb3J0ZXINCmFuZCBzZWUgaWYgaXQgaXMgYW4gYWNjZXB0YWJsZSBzb2x1dGlv
bi4NCg0KPiBJIGRvbid0IGtub3csIHRoZSBwYXRjaCBpdHNlbGYgaXMgZmluZSwgaXQncyB0aGUg
aXNzdWUgdGhhdCBpdCBoYXMNCj4gZXhwb3NlZCB0aGF0IGlzIG1vcmUgY29uY2VybmluZy4NCg0K
QWdyZWVkLiBUaGUgcm9vdCBwcm9ibGVtIGlzIHRoZSBCSU9TIHVzaW5nIHRoaXMgdGhyZXNob2xk
IHJlcG9ydGluZw0KbWVjaGFuaXNtLCB3aXRob3V0IHRoZXJlIGJlaW5nIGEgd2F5IGZvciB0aGUg
T1MgdG8gZGV0ZXJtaW5lIHRoZQ0Kc2NvcGUgb2YgbWVtb3J5IGFmZmVjdGVkIGJ5IHRoZSB0aHJl
c2hvbGQuDQoNCldoZW4gdGhpcyB3YXMgb3JpZ2luYWxseSBpbXBsZW1lbnRlZCwgdGhlIGV4cGVj
dGF0aW9uIHdhcyB0aGF0IHRoZQ0Kc2NvcGUgd291bGQgYmUgYSA0SyBwYWdlLg0KDQotVG9ueQ0K

