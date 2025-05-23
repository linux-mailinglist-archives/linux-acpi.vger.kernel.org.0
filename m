Return-Path: <linux-acpi+bounces-13868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62513AC290C
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 19:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC07A7B8D6E
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E6297A45;
	Fri, 23 May 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIlOymFo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F5293B68;
	Fri, 23 May 2025 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022481; cv=fail; b=Lu44yoXnzOt5h+huMOJrTsP38UC1TRYeuqChRBYLeEx67Is6hJri9eE4jSvD8udMjA9xgIc9QSNQj0uebwacEeLDdGS+k4d6XggOBIRaGfdbkYvE6ZxexJuG05MZjjDyMIJDBN6NmwC11qlRU1PzszN2TtZ3ft/Bwov1JQqLbkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022481; c=relaxed/simple;
	bh=Z86GmG/IF8FhjhRWsqlxD9VFUnaiZVHimp8UO3I8V1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NrwGzP8OfNXARjeBYT4RHQ9DA2lZiSCpfXFb6PyFQldr/KZ1pdWz8oSZzzzi4UP44ZSBvO0pYsm2jJUYursNpPigrXzUVydPa27b4yTg9eR2gRB+sDEfzXAiv09urPlELelzY79oOK/+DzUDWJ67ZjVi30nLJ78jXu6s07eVtos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIlOymFo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748022480; x=1779558480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z86GmG/IF8FhjhRWsqlxD9VFUnaiZVHimp8UO3I8V1A=;
  b=dIlOymFoTLpVFDiJAgpICi8I3Qj5XZaW9S/A8qqyJ6iORcqQXJYmWHWe
   CF5TPrYJ6Ds8Tgl4Xx95D2fr/WsvIZZPn0P54h2rRBeeLunZUKuhrguqk
   pRdhVd4ipMiobewDyZDx+xC8Vo8CwKhAonWt+TNgXshLHZF5PdksxQVJh
   O8NTWo3RByPAW2yMxGqVOgIbRwnYlnC6sG2PfQZe3DiG06DTH9YiCEXoa
   jTT22BlDrRFzEhu6mGFLSD8dygXsLdNQSKKYSUy6JU3rGyNcVuNPHvN0z
   pxTLibfVjWnfYG8nvIxDmWjidbI49XWNkp4MGD2gzKGOTTUZKHbGdaBo3
   A==;
X-CSE-ConnectionGUID: XNgN5sLgQTyrUvltxgaiUg==
X-CSE-MsgGUID: arEO10NzRvu+nldusk8m9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53894363"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="53894363"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:47:59 -0700
X-CSE-ConnectionGUID: IfXgeAA/SnSHk8iXBmpjQg==
X-CSE-MsgGUID: S0zP7FqhQRS8tLf7Wp57ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141118079"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 10:48:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 10:47:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 10:47:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.75)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 10:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piaLGTXbRTqDqlmhoAzbwf0qK7WRUESu1waJrN+xeVAJSifKS5ymEmzE9704GrqlhiQLioKR/K6dwOR+CSFr5Av1LUmH5clQOHww8dsdyY6oPYv+dw/xq485JZC5sMhw7W7AsmE3v0fu7sFhRFQe3B61La8Je1F1nG5mFWapU/VEeX7Lhf059bFWtDo2U5TH/jV796VF6f4pHXpp0Ks/AUcvMK01MFpxztpbAk3mBOz6f2wNJwFc+/jYNwI6/I2LhsBDw3GaM0J3fAV9AD/nHmwiRrk+b/3aYArBQinSn9VVsqdpvVId4ur5bRGRlPd/R6MlM09e6ZY3EMwBPvO7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrO6Jki7XRQa1cjP5tNzMlinFo54tHk2f+mjdMfAkvg=;
 b=aJEBLsyPBEJ+j/nSZMi/+coD7U3imahzV2SwcMgpEnooR9d0+3dXRyQVFtqN5tGfIgsO5Q2ySlTq/yRrcxUcn6uDf5mrBs8+UY9AnNkqlIkcng6lrqdDHeN6mrxm/09d2tnMTj6KAexR6/gqnCXO8qZew3l9vvrA+vnanPu1kLCOlgqXd1bDHL/lZ81I2ZTMZ9N3ujpJCnT/z3pEd0635nf6ztZFQ//7MU6Woy+es8vVGuGCkJxUf7UB+hLyWpSt2DlvsTSiVaLbVVo3E8d9pUiaLhr4LYXXezF3WyfN1e2SZu/Y1Kt09q+0HxfFUgSGpGzFmLF0IH3zicJeEkFA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 17:47:56 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 17:47:56 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>
CC: "Chen, Yu C" <yu.c.chen@intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] ACPI/MRRM: Fix default max memory region
Thread-Topic: [PATCH] ACPI/MRRM: Fix default max memory region
Thread-Index: AQHbzAbPRaLyd9QGU02gX55mjY0k4rPgfMYw
Date: Fri, 23 May 2025 17:47:56 +0000
Message-ID: <SJ1PR11MB608359E8F8700DAEC9D4663AFC98A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250523172001.1761634-1-anil.s.keshavamurthy@intel.com>
In-Reply-To: <20250523172001.1761634-1-anil.s.keshavamurthy@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4682:EE_
x-ms-office365-filtering-correlation-id: e10ae72e-9819-4976-d0d7-08dd9a21f33f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7fpCgCO+CGAMP4qyBHwaFima3m5MEo4h/QZsmFbWsIWDyHzeEKIFSM+0O4/3?=
 =?us-ascii?Q?IURXizIr0j6XF9KBfq12xri1TQNqxxzBBRbB9sjtu8A4OkPiU47FU9YZxQrT?=
 =?us-ascii?Q?S48AoS7ap7LCZvQHZvGy2guvERpu6B10B+Bz6L8uwZ+sDrpOZrIaPZnlbSv8?=
 =?us-ascii?Q?uAgIQWt0ASd1Y3exbGlcbRsh3xQD9tid4LccIT4f89N2peyARcg+VITaC/oa?=
 =?us-ascii?Q?x5iDLeXt7LUBLW9KciYhgga5j1VaAc/XKJL+zwAFOd5DInJFbuc+10YXXho9?=
 =?us-ascii?Q?85/hletZzYR5zpJ5+kMEDxeoX7yo6b0TFTdTictAmoAhBZpuovThXSOpPP67?=
 =?us-ascii?Q?kO7EPCU3UIMndY2hQfAuzEu/FtLNoCJIsxQMhvgZsa3yvF9rT7po0HCIIdLJ?=
 =?us-ascii?Q?rqjphH77l/1ut80VyC+J6XGUU2yVVtq7Ob7AhiFPGvgXcbxGEmfAzgGDISSu?=
 =?us-ascii?Q?LU6zqONZxCFLARxkZkVI/1izvrFiWZEp7hFmr3Lc2AneRpTwpLu1VpYtMu1Y?=
 =?us-ascii?Q?nVgI92Ivr/bbVl+3GBquqhZJqtNK6Cm3l8yqtO2gBH27Mx7Fpi+OIfQBm6u3?=
 =?us-ascii?Q?5e75o/xNMRxWmwOQuQz8ihz6OleLmQTJLc8kieOumgVn9/0K+LdMryaySHVE?=
 =?us-ascii?Q?wFT7UA0MdUo5dKvujltQBicZlQdNGbT0tWm9c3dDr2L6ZYWjmfGEWZkXDj9T?=
 =?us-ascii?Q?4OANvzqreEv12SOtkSd7H0Do0wNmBoaGnlkfnZ7rtfO7i9IYgqDRuoj1tpu0?=
 =?us-ascii?Q?81ISaWbbpegHPOUkrFV5gW3j4ACNcO1VphTQmAIpgPS3Z19BCWh26Jz7tXJf?=
 =?us-ascii?Q?COhIq6H4NSnGiyxBaxOSBLoaC3XaBoEX91TKIqUN1I1efOLQbseUf484xO6y?=
 =?us-ascii?Q?kc5OBCCUt3a85RffzvL78pt63I28Zwiloy5yMl8xTM+kF5dpR+qLc+dqJGMd?=
 =?us-ascii?Q?cr7AhDHi9jk9/kQDZPowZN0XGrxKnJaeQJ+o5depJCy94FDgm6nHkZyh9kuO?=
 =?us-ascii?Q?JXbEJH8QuyaExsn9wheoDLOubuNA28wY31ozOtiLc4ICKD3jDfi8Tr4dTxw8?=
 =?us-ascii?Q?byTF4ARTnWGrDrcaO1OKMi2X1jM9sJn3IXt0I008LXTOldh9WVPzUbhioek2?=
 =?us-ascii?Q?mdKgkYy1ADa5yaWqaT6f2nEafPAAZVMGOTDhmTA97vfwdejuYoL4NNFrAQ0+?=
 =?us-ascii?Q?reGn7TxKtYS1bRhe/Wr5uBMBC7Zgsb4VvovzimOdmFMLruiI+TtIJFEcG1Xg?=
 =?us-ascii?Q?D41Q9y/9NFilqzpa0arXlLlXFNxfW4BB/M8AIRqPXwrMDMQqHtsAlUqQIOga?=
 =?us-ascii?Q?s941MmEOQERdtuqGbiQFf2eM9uagPGmKt8AwvoNwNE/gqOnIrP0yJ5VyP9BS?=
 =?us-ascii?Q?zda6S0IiUnoGKxqLJtlrjuq02ru8lqils3KhY3JF1IXa9j0UU7SHwB4mHvJj?=
 =?us-ascii?Q?Rk10Yv4hrAnF9QD6YuF+9pSm9ECf0+KJVNS9YvP1AoEhC7ko1Jk6A6YuGsH9?=
 =?us-ascii?Q?k+aT1ZIqoJzfnpA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k6n31aqxobAL2jO09MBLQQkq2YSYJ+ZGMJdA6ae4JyAvj+iCqf8vTeejLh6u?=
 =?us-ascii?Q?YusGZDpvCvNzRAaiT5EPEfQ2YQTTae2l8XL6Ti+4xfyTpY+cE9c13umYKDjv?=
 =?us-ascii?Q?Q+8ESmIIjiOqNLahuvMKMtwNBqZQdbE6t9T+6YHv2g+fnMr5lD5f4vDbDsig?=
 =?us-ascii?Q?x4SIpEM7LCbf2CVj2uN1DcoCMOBtX75tc60Z0S9tQvwpaLk8Wyut8MPmJl9n?=
 =?us-ascii?Q?sUg0FWwCNPiXPOWFWzMmaYPs1DR9p3Gt88YrEvMX2Yljwgjmi3i8VuvQwQp0?=
 =?us-ascii?Q?BwMtlacsUsBJgd2cV2IFpubbsQ6wSKHQfyfvyh0i5p63mFkMxja1ItYz6Bjy?=
 =?us-ascii?Q?dpD5I7uplMgBEe2RteLAM6DBx1rEdgeIwyZzjmp0ERfB8oiNtcWivLxMY3hQ?=
 =?us-ascii?Q?wLFXbE64FzYQ267FGobRYcQQTU4SqJ4U6LWAb2yqDZcleoi+fYrVa9PjPIzs?=
 =?us-ascii?Q?T/CKKMmTShc6oFYLj+OAuiQTktNDI6jVqWWXRQXzSTKMt6tTXYrcE2P8adWK?=
 =?us-ascii?Q?JcevCBAC3pH8vLns0MyZ19BO0mrS5yMl1mCNPO03iw0fGKx2XRhDKV4p2Mbw?=
 =?us-ascii?Q?xR0JWufnltEqR7zf2Rgan4STQ/CQqzGVCFbIHwJD5rZOKNN5w76qY8a7jsv5?=
 =?us-ascii?Q?1Gj5e3zwLR/us+RKhg7HF0MAsL916eQVs1jJViMFbdkjGyjjz3vvNstwYcyb?=
 =?us-ascii?Q?L+ZlHqWwnAjO4aKYmUUMl6FbTAAHtGhKCJ3iezWe1bSZlGJmch+LSx8qeyzc?=
 =?us-ascii?Q?yS89DLxLUqICMGDOWcycpWySVVKK6iExEXsEHiOXP+kxOXTJe4I4Lcz8HIg/?=
 =?us-ascii?Q?rw462VO3ntwaq/Mjv2ysPtNzm8LKvmayNAEB2CRPJQAsehswJ+YpPnTvE3iS?=
 =?us-ascii?Q?DNBS2Mz5CLcdOZ3kvV3h9IA0LF4g3zhDGNwPuGAiS42LmG+MHOx702e7fDPQ?=
 =?us-ascii?Q?Nstx/AHnmvZD5SFKhSEurScxFkRvBtj8u5s95ftJ/fVg857PavhaowWXlkWY?=
 =?us-ascii?Q?azMlPACAF5MShaKji2vGKpMn8TcwMggxTgC8JNDa7lR4QyC93W2/KAf395Vh?=
 =?us-ascii?Q?zI8XRjgUDeb79V9UG7vWj4FyGRs8SbSjb9sntozaovtPp9/HFV1TfQk16+7s?=
 =?us-ascii?Q?X4Q4gqShwV/tPitGFzrnfnqDeqZGMjoHStb3+fESAr4NkFnu5PIf0Fa1AGbz?=
 =?us-ascii?Q?s4vF3fVgbrbV1JZAp7JQWDXy5cW+fMJufjwCxmptVRfLkU27xkIud6z1fJkv?=
 =?us-ascii?Q?Fb8TJXJflNqp4dJdNLZK9BgsFu24j4pkUORCfVuf/1my95K/e0b2Am9Iccn7?=
 =?us-ascii?Q?TAqorDJ3DK6BbwRJxNwjsxC1PSMV+BAuoRUOMMUw0L6Uc2OrsidZlkZgPhwy?=
 =?us-ascii?Q?wTKE6UZTfZRIVdsEvsXy7KP7lJ6gtpxUO0yUbQSU0qWFZWQnz22nmIft2UHe?=
 =?us-ascii?Q?yYubE8zvfKDKwX/lRgkFEXoFXKIGqBdld0wwvdxdfBFAE0bpBMmuV2QzL1O2?=
 =?us-ascii?Q?hpg30NWqzLS5oTWEe3bP0T9nFCNXepxBZvr65LjDCPleWXnYRLulmSHbaz+g?=
 =?us-ascii?Q?86g0e1QNA1trdClYVFpp8u6IxfhsyVGv1ER1rN0U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10ae72e-9819-4976-d0d7-08dd9a21f33f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 17:47:56.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eox5jeEMe9pwbJGHXves/zXREF2XVzp5n6ae7ljQu1f1uHNV3nMYMglOiuByPMy9ehANiODbXnGAkf+6DBrntQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com

> Per the spec, the default max memory region must be 1 covering
> all system memory.
>
> When platform does not provide ACPI MRRM table or
> when CONFIG_ACPI is opted out, the acpi_mrrm_max_mem_region() function
> defaults to  returning 1 region complying to RDT spec.
>
> Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

Good (corner case) catch. I was too focused on the assumption that MRRM
table will be present when needed. Always a good plan to have a backup
option if BIOS does something strange.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

