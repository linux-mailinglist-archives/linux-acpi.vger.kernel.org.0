Return-Path: <linux-acpi+bounces-11157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FC7A34E31
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 20:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7FC16B0D6
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F286245AE6;
	Thu, 13 Feb 2025 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjViNCRp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583315252D;
	Thu, 13 Feb 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473558; cv=fail; b=VSYKqBmCYs4jlRFmII47GLcczofeGPeyZCgDT/xuxQNiA4s/jFuAhws86bfjNvbqGiLzog9QTM7gCWcO5y1VeKpLZFyqXHx1lGqAlfFkSmNYctllPxGDXUVYJRwMmmRla9TDhH+rHA3fvJ8YJ68WtZpQ/F5L4sWK3zpeDwtDzj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473558; c=relaxed/simple;
	bh=HkevIt8YK9aNgoSkmP/EMMcM0VtsAiiuxbPx8QiEkeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KGiCKX/L5yqy3TvNXj6GVi8AwqeBDsuKEkldfrdPakHoi11iBYqEfR9/dJUFwInlQWeWXVx2fHiLsB+kd8UIGMieffKrnG3LAu+mBZxn0n7qJw7yhra/xWKF74Ogf3UJ/wOF3mzUtQRSmxA5siEG48b7mdb6GuyV0GL2wqWWQcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjViNCRp; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739473556; x=1771009556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HkevIt8YK9aNgoSkmP/EMMcM0VtsAiiuxbPx8QiEkeE=;
  b=hjViNCRpPm1qDet/bBEjC6bdGyYKg0SzBZCvpIYK3YALI1e0qDkn/CED
   f9GWVGaZmzcnhm+UXrSWUw8BY37NopNtvwV14JEJ0h3GRgxgopXZra7vn
   bs6isTZUgYjEBwVFej4QEAJ1jzM2POJXaABsS/x6UNbZknZDnvIV2xQK+
   8d0OdsuxAsRB6hDy8/8Rln9T8TlWNAdfMNDxH2wppsVvvW9OCjhDQXJUp
   5zO14e+co9qzyvj9uFV4e5SZOdVLUCPr1BFLPXqRQCEP07f4mR0TSfBvs
   dzl4+C011siiebcbwqJMGh+Vp2xI8NSY9IbjuCxa8Tu/e1ZC/PA/PFxAG
   g==;
X-CSE-ConnectionGUID: vItpVIKaQFGNURZyvVEW2w==
X-CSE-MsgGUID: Egsg+aunSfO2cW3xYQLTBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40459649"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40459649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:05:55 -0800
X-CSE-ConnectionGUID: 2lxTz84bTEiG7eaPkYrJJw==
X-CSE-MsgGUID: cTOFhzbRQLCq7/0HSMaIoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144178810"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 11:05:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 11:05:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 11:05:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 11:05:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ypnn3OcqLaOx5zh+fzWpeqVA8idIlITHhkUOC7KHwsbbpEO22T9gENAlaVg1WHsrZ6zmrjSvVEtRIlOrX/LU6fEOXNcg6CTsmblM0+7KdEsfOI4VcKK+vToXHp/bK2GeYSOuTouywOd7U2npTBn0/07QSiocqXZUoN4s+re6POYYXNUX6ji2KxlwC/PnToW2jirTeNiWURkSpYzMW2rC+VvW6YEKGFoooSu33T4WljAz/68PtPJ+9AJyZRIDIeq5ipzrJixDNaEAvlVMnivi3+2YSEITv1Ap0woe4xdjIqP5IkLia+WPz9Aosz6OzI2BeGk5FPmuugMuL+r00GEvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkevIt8YK9aNgoSkmP/EMMcM0VtsAiiuxbPx8QiEkeE=;
 b=XE3uW35kv22eIBwXWsxGjIfIiY8B66QQ1fknoV8MWldcGEpAcW978adqDkx2yV0PKj2wWjEso+6N1ujqT635KpGQv4VgV8O1wkQ6Irpgm8nMHnzHJ0BumGXGxQKZR5cHoukPOiEvCaw3HFJXpjrAC+0P10zyx1e/PD4EDzzfnrKtzJuu0ob5pRPMqUX5+qzR/mijNSbbL6LvINf2aOnfsCi7PhDOm6l8/lb6hYL8yiQgE4d8YbkgW6QnPGvi80qzf1R40q6sY8e1BqNt/0TQ5NchZElvOSnh97ebwU9d6w7LJ+yWcuO/UV6EDJTaCJCpdOEHCWfPDdyv2q2qX+RwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB7699.namprd11.prod.outlook.com (2603:10b6:806:338::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Thu, 13 Feb
 2025 19:05:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 19:05:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Oscar
 Salvador" <osalvador@suse.de>, Danilo Krummrich <dakr@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Thread-Topic: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Thread-Index: AQHbfACE0Yu2SiLzv0qtSfoPrdz0Y7NBqsKAgABurYCAAEh1IIAC3SOAgABaccA=
Date: Thu, 13 Feb 2025 19:05:50 +0000
Message-ID: <SJ1PR11MB60836038251DD6AD5866E631FCFF2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-4-tony.luck@intel.com>
 <2025021111-deepen-landing-4252@gregkh>
 <d19e60d7-8abb-4e46-8935-bc989b1d5d68@redhat.com>
 <SJ1PR11MB6083929661A91F9F60F7C8CBFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a93beb19-fa0d-4000-812a-a4bfd88d40e5@redhat.com>
In-Reply-To: <a93beb19-fa0d-4000-812a-a4bfd88d40e5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB7699:EE_
x-ms-office365-filtering-correlation-id: 56a912eb-6ab1-419d-6071-08dd4c616eb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z0tVelI5WVhDY1RrZmF0aE8yZFVBeEZBUGRYL3Q0eFNPalYwTm5YWGJ4U0hV?=
 =?utf-8?B?SElQaGU3cEFPWWdnT2pwVTF6ZWoyMnB1Uy9VaEwraWZoVk8wL0gzRlVFV0lX?=
 =?utf-8?B?Lzdiazc3MElycUI5OWlwUi85VFEydmZZc0VEQklML1J3d3lkS0NKblhtNHFK?=
 =?utf-8?B?T1BCVXJhSEdJSHg0cFJqOEsxTGtFbmI5WmptT0kwNnc3NkZkcENab1VRQnNu?=
 =?utf-8?B?YUFCNDNBSWFkOUQ1Ukp4OU55RTFaYldnWTloTVBDY05EVmNIYmRjZW04V283?=
 =?utf-8?B?T2FCR3JsZW9LZ28wVUlUYUcyNlJydlNFenpEa2IxeWYwTXEwckdzSS9tL2d2?=
 =?utf-8?B?VXVKZitmem9MVmF5dTRjaDR5ZXJvYnFjMk1BUEZUeVQxV0FMY295VnJNaWM1?=
 =?utf-8?B?OUhqQVlEK1BQbFZGRTh6NU5xcTIyS0YrRnk2ZFNvcXhtTTRpK1c2ZFhTU2dq?=
 =?utf-8?B?R0grODhoUnlrSjdoWkFNc1c2aUtQcHhSN0pyZEtIUGU0eENSeGtYRkRSWG9G?=
 =?utf-8?B?Ym9qdFNTMWc4eGxuTUhrWmowUm1IZkJSVldlMTVRYVpwQTBZWDNQL1pMVVp0?=
 =?utf-8?B?NU0zaExncjlnTHBXdWFEWUQrZUUvMWJNY1E2eW1hbEx1YjJsc3BNMU1KSUNv?=
 =?utf-8?B?OEJ5dlA0SlNJWTZ3aEVQSTFjamJTbmxLTlFnZ2ppK1RqbU5aT2RwZXcxSUl2?=
 =?utf-8?B?TCtDOHVYWlF2T0ZqRTFvR0ZnS1E1TmxJWlRQN3FYZ01LLzFVUHk4QWJ5UDRQ?=
 =?utf-8?B?OGVNM1ZUZGd4d0NhS1A2WGlZNUtLOUxLOGVFL3ZTQjBZQ2FKbG5BSS84NFky?=
 =?utf-8?B?N0k3Z003OWQxcjdYVHRIZlFPRmZCYkU1Z0N0ODk4bGt0SGV5R2ZnSkZHNnZJ?=
 =?utf-8?B?eHdRcjlwRjZOK0FrTEFvWkVyRWtENzMwZjViYURrV0RTY1ptS3lNRUlxcHZy?=
 =?utf-8?B?clFnTTdMRWpvcWtvOUJVSXFQOUR2b0dxcm1IV3o5Q2Fqb1BYcE9IbWcvK1I1?=
 =?utf-8?B?NGtJTFZuakNPL25wcEtsOXdmcHlvNXpXTUQzczdsVzVUSXJFUHlrMlpwUk1D?=
 =?utf-8?B?SXFSZWR1dk9nK3hheEJzdlNHVXBqdFdqS0E1K1RVb0wxTnY3bGF2UXUxNlpI?=
 =?utf-8?B?S3hqTDh3TlBnekZBdFZmcjBJSk5Fa1ZEYTZUU0x3UlQ0MVdtSnQzNlJHaENn?=
 =?utf-8?B?VGhFNlVVVTR2MHdZencwbUpsVk9nRTFFaXpRWEhEZXZEZFk4OFk1U1J2YUpw?=
 =?utf-8?B?Zzd1aE9TTHV5bTkzNldGc2VJUnF0MEZJcGh1YlAxOW15cHhKdGZIYkRLQ1FP?=
 =?utf-8?B?QTk1b3FMYUdTcEJCL1RrT0t0ZzVnazUwMU9GQjQ5YUVjRTFPYTZXbWNrcFA0?=
 =?utf-8?B?c2pDZkIyT0JzWkdXRnI4STRxd0JGTU85dDNQTFl3UWxMbHR2SjkzdWtXb1A3?=
 =?utf-8?B?Q2JkSExhVVpYQkM5enNwT0NaMEtJNFBtYk5jR211enlhSTQwWDVnT2dsTDFO?=
 =?utf-8?B?cHZ0WVVhRGxmbWFZUTBSN2lEcG1sRExyVS85OUZBUTFwL1dQdnE3TExicUJl?=
 =?utf-8?B?YjdzQVZRYUJuT3hIWjhCcWpMOCs5dUJLclZVY3cxVjd3SkFybXlBYlgrK3c0?=
 =?utf-8?B?VVd0REdZZ0dobjRqb1JlK2djaWI5dHlsWmRYTVRWVlJrUUpRdStoeDRmQnEw?=
 =?utf-8?B?REtwNTV2dzZYN2dOOGw2VmN1am9NZUpKOHNwaGRROFdhd2s0N3ExeFpSeXBr?=
 =?utf-8?B?QW8xcmZmTFhZZUZzRzUzVDBZWDBnQnRPK3BzOS9HL3RKak9GQVR4dm9ZZk91?=
 =?utf-8?B?WHJGSnBWeWRJdmNOVkFiQnNQMlh4QlJ2aXF1akM5WVI4WTQxNm5GdittZ0lW?=
 =?utf-8?B?TUtSRFl5SW05VlQrblpQbUJwTm9Xa3h6aitqQXcydlRXQU9ReStJM05ETDd6?=
 =?utf-8?Q?kZmL55ldshaLqczKFzY92ZFTHKD8WVAZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjkrSXpucld0UUFQRlhCYlNXYjZKMWo3K3lzZFNZVXFDWXZjdCtSNVJkN1dY?=
 =?utf-8?B?bGVYWGcxSTh1eEpiOVF3UjliMXZpQUxpUDQxTFhwZUpOc1RiM1hzYy9VUG9Z?=
 =?utf-8?B?QkYvM2FvQXNZVWVZeGV6US9yK215cXl2Ni9pZDkzQVZwbFYrUXRHcEtZcW5h?=
 =?utf-8?B?UzBlWnV6RVJXSElQeTFpMTUyb3MvN1VyUEZDRG9iNXF5ckRpKzhOTUJzTVVQ?=
 =?utf-8?B?aFoyNVJ5MXZyd2FFWVAvdXZOa0hFMCt5TkRJNVRMdzNyMDV5cisxWFBoOSsx?=
 =?utf-8?B?UTA3dGI1ekpPUmQvb3BnZkxVc0Z5VTRIUTlSVmowWUU1d3Eyai8xRGw5YVBU?=
 =?utf-8?B?eVlRcmFZNUdCcGpHRHN1aWJ2WWRsRXArQ1hZd3lMTGF1Z2ZBRG1ycFNLWjVU?=
 =?utf-8?B?ZUpuWlN4bk56RnlPVGt3Nm1vcnlVbjFHMnUyTVRyMnk3R0NndEwwVjN2aEQz?=
 =?utf-8?B?RDRyMHdiYlQ2NXJCU0tlOVQreFRCc2wvaVp6MHgzYmhSOCtBb2NLZTBmOTNt?=
 =?utf-8?B?Q3hscng2YWg4T2tUNk1oMXZyaHNmWnZRQmdOeE1qSU5mUGJ4NEtOZUlya2Zq?=
 =?utf-8?B?R094Skt4S2Q0dEd6aHNaenhLdFdaZGZQS3dmTnZTbjYrMnRwSTNPZGF5ektt?=
 =?utf-8?B?K2Z0QWdmbTgrS1dkemtwbUEzS0V1V1hpeW43Zkw4NUVEZGRZc3hvVFQyRm8x?=
 =?utf-8?B?SlR3Mm1mbGR3MG1YeGI2TVRCckN3dm1Lbkt1RTNscmZoUVcxUkNqUFJlU3l4?=
 =?utf-8?B?UHZTNUUyL3VFb0gwWmd3dFpZSFowcnpJUmZFNnB0Y2JEREJ6MGZEaGNhKzlO?=
 =?utf-8?B?YkdjeGt6cFNJOFc2OEd5ZEgwZWVLSmVEVlNYWkxINHhEVGgzTXIyd0RsNWJ2?=
 =?utf-8?B?Yy9oMnpnOTFNYk9WU1lPeTlhOTR1a2lUS21Ncmh3bU0xanlkdThNaDB4S21p?=
 =?utf-8?B?UGN4TlhZVFFUajRKeHA4cTE1RkJ6WGlTeWtYV3JuSStrRmJCQkczYkMwZVk5?=
 =?utf-8?B?YUN1Mi8ralkrL2NmcWJLRzRwMi9Qc2xxeW9RZS94TXhMb3JUQkxDK29zbTFL?=
 =?utf-8?B?QTNxbFpiak9HL2R0M2N2cXNqeDM2amZkQ1pDRGZQV0V4TnRvbStDajVEWTJR?=
 =?utf-8?B?eCs4MVozL24xcit5RXJqMk94L0Z2R2V0Zndoc1ltcmJWcFB0NnlxdU1jK0xG?=
 =?utf-8?B?cXoyaWlZQWRNeTdPNjBsaUhOUTFpL1lDWDl1V2lqVG1hOEZ5YjlYVi96NWJP?=
 =?utf-8?B?K3JXWkpvbXhDcHM5SS9XdDhuZ01uUUo2QXRoQ0c1M3FBMkVmS0p2bXA0SjNj?=
 =?utf-8?B?RmFaNlg3akg5UXM5cHlybDd0MlhkSDBZaUE4WCs4L0hmdlNXaW9uek0zNWJt?=
 =?utf-8?B?VmgzaFhVSXFzRjN5Z1AwWE5zWG1WZXBCMmFobm9LTGZsMlF3Nm1qQ3NsbnRs?=
 =?utf-8?B?ajRBMDRTV0dqUmxyY3BSTmNYakN2eDB0MEVrcU9yb1R0anlWeUh1VlFhZnQ3?=
 =?utf-8?B?dnNGeW0zQUhjR3BKaHVPajhEeGFWSWxFTjV1R0VMSk9VYUhZQzREZDF5MWEv?=
 =?utf-8?B?aC9icTY4ZXRWZFBZa1hWSVdBYmI3S3U2S0pSODBjQVdXMFN3OEttbkVvNlVn?=
 =?utf-8?B?VnNKSkdJUm1JRDhNbkpLcWVyQjJWSmkzVkZEMStKR0tTajAwMFRxNk1qOHUr?=
 =?utf-8?B?eVUyTVJ0S0dla1JleXd1Umc0WVNnN1hHNVZZLzZiSm9FWUR2VlE2OW15TEtj?=
 =?utf-8?B?MEJDbTVTdnA5RUx2bFMwcFd4TllFUGthOXRIZGQzMXJ5VXhPOHpMQ0ZvL2F2?=
 =?utf-8?B?RjlleXlmMlh5Z0JHb0tYSkRhWS9XTXhlRGVxdlF5RmxQRWNQU1cxRzR1b1c1?=
 =?utf-8?B?UjF1aXY0YXNHRCtPUVh5MHBibE9WcTZ3NUtZVjJubW5mdnB5VVZ2SVZkS0lM?=
 =?utf-8?B?MjFSQWdnTGRwbmhtbTNtMnMvREt0WlVLRm9qTEFLTCsvaGxvd21uQ3V0ZWJP?=
 =?utf-8?B?MTBpdWhKcmhleHo5ZjRZL2RIZzZtV3VLSmllaFZmN0IrQkVUc2l2N3RtbFhs?=
 =?utf-8?B?VTUwc3VwbU43UHQ3b0dEd2NndEp0UGxLVCtCL2VPZlIwbGNRUDRuNUtUMklz?=
 =?utf-8?Q?g2mPWOlK9IhKGh/IPvKQ+WoHy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a912eb-6ab1-419d-6071-08dd4c616eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 19:05:50.9161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3gp+wZMN96SnjJnrwDYNA64RMEzfGKK0/eL1+bw7sPVgM9MZEUJXMb0L/KZZ/wn3PA5PAe6BeBsuTpaVlDDiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7699
X-OriginatorOrg: intel.com

PiBBIGNvdXBsZSBvZiBxdWVzdGlvbnM6DQo+DQo+IGEpIEhvdyB2b2xhdGlsZSBpcyB0aGF0IGlu
Zm9ybWF0aW9uIGF0IHJ1bnRpbWU/IENhbiByYW5nZXMgLyBJRHMgY2hhbmdlPw0KPiAgICAgSSBy
ZWFkIGFib3ZlIHRoYXQgdXNlciBzcGFjZSBtaWdodCBpbiB0aGUgZnV0dXJlIGJlIGFibGUgdG8N
Cj4gICAgIHJlY29uZmlndXJlIHRoZSByYW5nZXMuDQoNCkluaXRpYWwgaW1wbGVtZW50YXRpb24g
aGFzIEJJT1MgbWFraW5nIGFsbCB0aGUgY2hvaWNlcy4gV2hlbiB0aGVyZQ0KaXMgYSBzeXN0ZW0g
dGhhdCBzdXBwb3J0cyBPUyBjaGFuZ2VzIEkgZW52aXNpb24gbWFraW5nIHRoZSAibG9jYWxfcmVn
aW9uX2lkIg0KYW5kICJyZW1vdGVfcmVnaW9uX2lkIiBmaWxlcyB3cml0ZWFibGUgZm9yIHRoZSBz
eXNhZG1pbiB0byBtYWtlIGNoYW5nZXMuDQoNCk5vdGUgdGhhdCB0aGUgYWRkcmVzcyByYW5nZXMg
YXJlIGZpeGVkIChhbmQgdGhpcyBpc24ndCBnb2luZyB0byBjaGFuZ2UpLg0KDQo+IGIpIEhvdyBp
cyBob3RwbHVnL3VucGx1ZyBoYW5kbGVkPw0KDQpJJ20gbG9va2luZyBmb3IgYW5zd2VycyB0byB0
aGlzIHZlcnkgZ29vZCBxdWVzdGlvbi4gUGxhdXNpYmx5IHN5c3RlbXMNCm1pZ2h0IHJlc2VydmUg
YWRkcmVzcyByYW5nZXMgZm9yIGxhdGVyIGhvdHBsdWcuIFRob3NlIHJhbmdlcyBjb3VsZCBiZQ0K
ZW51bWVyYXRlZCBpbiB0aGUgTVJSTSB0YWJsZS4gQnV0IHRoYXQgaXMganVzdCBhIGd1ZXNzLg0K
DQo+IGMpIEhvdyBhcmUgbWVtb3J5IHJhbmdlcyBub3QgbWFuYWdlZCBieSBMaW51eCBoYW5kbGVk
Pw0KDQpJdCBhcHBlYXJzIHRoYXQgYWxsIHN5c3RlbSBtZW1vcnkgaXMgaW5jbHVkZWQgaW4gdGhl
IHJhbmdlIGluZm9ybWF0aW9uLg0Kc28gYWNjZXNzIGJ5IEJJT1MgdG8gcmVzZXJ2ZWQgbWVtb3J5
IHJhbmdlcyB3b3VsZCBiZSBjb3VudGVkDQphbmQgY29udHJvbGxlZCAodW5sZXNzIFNNSSB3ZXJl
IHRvIGRpc2FibGUgb24gZW50cnkpLiBJJ2xsIGFzayB0aGlzDQpxdWVzdGlvbi4NCg0KPiBJdCBt
aWdodCBtYWtlIHNlbnNlIHRvIGV4cG9zZSB3aGF0IHlvdSBuZWVkIGluIGEgbW9yZSBzcGVjaWFs
aXplZCwNCj4gYWNwaS9NUlJNL3BlcmYgc3BlY2lmaWMgZm9ybSwgYW5kIG5vdCBhcyBnZW5lcmlj
IGFzIHlvdSBjdXJyZW50bHkNCj4gZW52aXNpb24gaXQuDQoNCkFncmVlZC4gVGhlIG9ubHkgdGhp
bmcgZ29pbmcgZm9yIC9zeXMvZGV2aWNlcy9zeXN0ZW0vbWVtb3J5IGlzIHRoZSBuYW1lLg0KVGhl
IGFjdHVhbCBzZW1hbnRpY3Mgb2YgZXZlcnl0aGluZyBiZWxvdyB0aGVyZSBkb24ndCBtYXRjaCB3
ZWxsIHdpdGggdGhpcw0KdXNhZ2UuDQoNClJhZmFlbDogSG93IGRvIHlvdSBmZWVsIGFib3V0IHRo
aXMgKG5vdCBpbXBsZW1lbnRlZCB5ZXQsIGp1c3QgbG9va2luZyBmb3INCmEgbmV3IHNwb3QgdG8g
ZXhwb3NlIHRoaXMpPw0KDQokIGNkIC9zeXMvZmlybXdhcmUvYWNwaQ0KJCB0cmVlIG1lbW9yeV9y
YW5nZXMvDQptZW1vcnlfcmFuZ2VzLw0K4pSc4pSA4pSAIHJhbmdlMA0K4pSCwqDCoCDilJzilIDi
lIAgYmFzZQ0K4pSCwqDCoCDilJzilIDilIAgbGVuZ3RoDQrilILCoMKgIOKUnOKUgOKUgCBsb2Nh
bF9yZWdpb25faWQNCuKUgsKgwqAg4pSU4pSA4pSAIHJlbW90ZV9yZWdpb25faWQNCuKUnOKUgOKU
gCByYW5nZTENCuKUgsKgwqAg4pSc4pSA4pSAIGJhc2UNCuKUgsKgwqAg4pSc4pSA4pSAIGxlbmd0
aA0K4pSCwqDCoCDilJzilIDilIAgbG9jYWxfcmVnaW9uX2lkDQrilILCoMKgIOKUlOKUgOKUgCBy
ZW1vdGVfcmVnaW9uX2lkDQrilJTilIDilIAgcmFuZ2UyDQogICAg4pSc4pSA4pSAIGJhc2UNCiAg
ICDilJzilIDilIAgbGVuZ3RoDQogICAg4pSc4pSA4pSAIGxvY2FsX3JlZ2lvbl9pZA0KICAgIOKU
lOKUgOKUgCByZW1vdGVfcmVnaW9uX2lkDQoNCjQgZGlyZWN0b3JpZXMsIDEyIGZpbGVzDQoNCi1U
b255DQo=

