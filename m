Return-Path: <linux-acpi+bounces-14982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83684AF7F6A
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 19:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8B858371A
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8225524C;
	Thu,  3 Jul 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnwK1yNJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADA28937E;
	Thu,  3 Jul 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565068; cv=fail; b=JKd03hKeNFPzCoXMaBfQKGUOP5yk3XmMXoROIX+HeX87Qo9QmjHRmaTcjUJTpRxr61Ne2rJyL2bFryHO65j3Ld9NA3YO1/H2uTyWelsY/U44p97jzOIjExhxeIhnhmvHyIvthgfHB0q2V65Nwryvv6DzetKjg+RTA04wvv7L0FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565068; c=relaxed/simple;
	bh=LuPHlEq/ssu6Oni9LCah4m5eSBM4Tm61TmgoQoyByho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+HF/F0U2HEpAo+QQ5V+Jrc7td69ClbYDegQ1HcSfaucc+ptc6ufm17bfnphV6DVOBzpET5tpwM4flG3W719jydA31XmtJiSUP9p73JkwxsrB6jqiqJCOiOjEpy9aHaBNsZuyzfo/JEFcBcGrdGjPKrLSZglBa/BtXkZqVHxITg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnwK1yNJ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751565064; x=1783101064;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LuPHlEq/ssu6Oni9LCah4m5eSBM4Tm61TmgoQoyByho=;
  b=PnwK1yNJIGVCwNXz6F1lJubdQ5ijZOn4XFiKorRV3bekM97/q1WbHuYy
   71g1hnFQNTaiA+t0F6fsESfCvOj+IwOQQwMwoRz6QXjRkCOjXboOs6wYS
   mPCtD30XYpQQJOe1i9sejYEONl0xCLYqAjwe6e3CE+NwPz+lNZVpAjJ7J
   BpRIU2i4ODqCsmhoXh8S8j08pqV5wLBGzpV7696zcP05iljDY55KmBlpV
   lmdNgc4bZrRjySfv0eIbS0fS+QeU4U9i2V+fSM/QcXz0bcA1B7kBptaUB
   Q8qMRuHj++BnyLqt5YWzgA2OK+i5rEwQvkop+LDi0++WmuBcmqSkEQdAN
   A==;
X-CSE-ConnectionGUID: 2AWo4+i7QK+OUZSTHf91tw==
X-CSE-MsgGUID: QBvdudzvT+uARGw8b4LQLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53873619"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53873619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:51:03 -0700
X-CSE-ConnectionGUID: iL6uTakuReu8PJ4Xupm7/w==
X-CSE-MsgGUID: xYZb/IWQQNSI7Z9FBug+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="185451745"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:51:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 10:51:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 10:51:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 10:51:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHVRHetf/b2kwCoqB2O/VvFOUee/rpuhNc4+RIchHyhAGe24MJ3yIOyxxY3PbS3aKiXOM22Z8xT+pA/qG/0L3Pp07b2nP6ROanNLzDKHZiAq9BbDSd7XOm2pU+rr+jk5aJKZpcNlcxxQGdSGSv6ZhEW6NzjbQD+IspORMOfxybr04WsLIUmjXjSyYGqbWA/3CW4m/2AnjZlf+W3voQ8GkO2UwtfRH/V5NunMLwB5igRQV5p3QySMsuwnY77dmdGH5gEOwhefIW16yHytLRsfnUPdeJV24pkin7er4fLqaygL9DRBobwmGiSfGxu1MesMk5nqkGZX8mtQsOPa4KsZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuPHlEq/ssu6Oni9LCah4m5eSBM4Tm61TmgoQoyByho=;
 b=nff972bMeCy1D+K9d9Tv1PkgSJ+9eiyos35P7rip936EFbsT3ItSdJGgnd5EzB84JEvVmDcLFhH5vxlPQ1kh8MbDfXwMYRCIdlYfw78MXJwPin6q0BefWZC+fh1emj32Oebz5Pk5r0PWAOt99xcHTvnLrvzo1w+hJNMOkbr5zhNmnBxBrN1N/4Bw+k9pgx0FIciRXFTIxDWSlYVKaPi1l6npK4uuCyAwS23yBlY5cw9fta26nI2rPngtiRGE4xelLjP3LT2xzMDLvMTMsl70znCuT98mWbxhHxmUVOQIe4TTKlfPJc2bXBR+/MqUnX0XfOJulev9FqFnnXAqUeaaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 17:51:00 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 17:51:00 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Breno Leitao <leitao@debian.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "rmikey@meta.com" <rmikey@meta.com>
Subject: RE: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
Thread-Topic: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
Thread-Index: AQHb62euNpBgT5i5yk+4DnYh4bLwA7QfFSglgAEGLRmAAI85sA==
Date: Thu, 3 Jul 2025 17:51:00 +0000
Message-ID: <SJ1PR11MB608389A75F07F37C79CB099CFC43A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250702-add_tain-v1-1-9187b10914b9@debian.org>
 <aGVe4nv18dRHHV16@agluck-desk3> <aGVq6khN+QdqD5Aj@gmail.com>
 <aGVyX0jqwTPkCVqY@agluck-desk3> <aGZGzaGeldWYHOwG@gmail.com>
In-Reply-To: <aGZGzaGeldWYHOwG@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH7PR11MB6608:EE_
x-ms-office365-filtering-correlation-id: a9285508-32c3-493b-1592-08ddba5a2bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iAMr7d5Byky3KMIi5NLpepe+FyDxsLrVXBzuTvkuwyQp8OvJAZR8VPGrWjoQ?=
 =?us-ascii?Q?QD5Km5AQW9I5WZHCzokqF1MYp6acULyt4MsB+dPnDi4tEFItsQHCbCoTmx1G?=
 =?us-ascii?Q?7hXxzqBz2dsIWYDybnZ2B+jB4v1CN0AQFj+61VwiMw6wDUgwMcycz4EmmaTJ?=
 =?us-ascii?Q?m/yNoIXgC+0C0hRSG+kHFXfQJ0/PNAvWsKuk/3pFUQP4Wt+P6GJbeSOpdY0c?=
 =?us-ascii?Q?kZ6szbEFUIqlX0xm8LGkvMCgU09eeE+0KnlmqLja8N8EkoV1c7hmzR9ryNeq?=
 =?us-ascii?Q?nNpL6kEfPxcKkyY/zDQfhlThfX6hkBYzx+uk5lsRnaUOSDRseHEY2j7/TFFi?=
 =?us-ascii?Q?M8E4q8By9jDVB8Ai9b/RMtG/h+Ny4ZJCPzr5Kl40zuflykgNDLLR6nyy4OQS?=
 =?us-ascii?Q?BJTsO9wZiGzohBDMLhqbQp0uzRcaaeOgrhay28q7kJtryLiToB4F7rtjMnmb?=
 =?us-ascii?Q?fYWRK3J8CdFASL7nRt26vAxDOqQuPGkVVCTuZ2jbYiOmfGADmfERAZv8hbj5?=
 =?us-ascii?Q?1zwZby3M5TEr1Fb4zpZ7/lWc3gmAahh0thmZtpYVLh6MGtv7CvvV6+JwajeX?=
 =?us-ascii?Q?RlQQp+SBu0wyUQoCnUzJe/R/+IBgPdFpcMdHQgpmXd98TeHPiR+ZgSG3yIIF?=
 =?us-ascii?Q?KFFmykN0iQOEJz755411juy28BqiqOtbEyf7R/5iy0cZ5Klq8awpHnE+/IrV?=
 =?us-ascii?Q?WD6gN8htUhuHuhmPD2m+MlakgjmSYuNl73dYx1TrHLSTiJ9yvFjKpq7HjTCB?=
 =?us-ascii?Q?CFvthHc6UbK+b5aF0CYqqh4SW3fS8ZjUhzPg9ssw1PcBEd80LyhiH3IzRJfe?=
 =?us-ascii?Q?H+tXk7kwrxpWm8GIQorz6aXsD4DlkjOMf/KAIlnRbJiObAbT1ebRgICsi5+R?=
 =?us-ascii?Q?clRbi2zgWNW1mD2mCKXVsgOykBTJnPRM2qnnrzP1hoDIYzETEr5UqnAi6wZD?=
 =?us-ascii?Q?pBEQXMPeYBMoBT4VAjxyGAVS9qfMRSlVeWCekows8gR86glCcZv+6GGjkWhH?=
 =?us-ascii?Q?+UxM62wSKN6F/Yfcmi0k3CSU9nGVQoo6Zp1QOWk5SEhl3h0wm8kwOY1BL3tM?=
 =?us-ascii?Q?/Rv8Zi0TeyTynj/6sqWQtz3OgpDAmhIIB1WhQw8phl3aIk0Bd08mTArNOAgL?=
 =?us-ascii?Q?hM31dUrNl1J7OoEkPUwCDLe2MKIDQ5iSWWGD97gchBHDKW8141X+D47AHEgW?=
 =?us-ascii?Q?5MlzsrB6F8u4UKexBedOBRX/t0KPTV9Jp1C7kgVKbGXQXJUJl9+wkQ06Wqs0?=
 =?us-ascii?Q?qbsccblDxv+dZkGKYAhR/zDQ17QwTcLptaYvwZK1+kHK3C1P0VrVWOW1QZGu?=
 =?us-ascii?Q?xAOMaWFJKRvgQbi71bxyr3gjPCTEyZzp4RfQG/sc08B4/UoGwXFWYbCVCL3U?=
 =?us-ascii?Q?R8dtZaQ7Evnc2KSTasju1zzECIZy9Me8EqynhxY2Cqe2JTnqND8pmBmBbiuu?=
 =?us-ascii?Q?s7zx7RBOZcTOCz0GkWLsrt7XF5TCBpQXvhWL7rxzEiHLtRrs2/KLekUMJaqX?=
 =?us-ascii?Q?0dX9dT5JruiiKBI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rT2fGRw7SglcdZRPx1w/wPvkS418fMdSTH9b42i265Ju1k9UoVeMBU7Ot9qh?=
 =?us-ascii?Q?v1fl6lzfREWJJrBFe1ogLp8Z2x6YVTet2mXincS2XPIIeBkWS64A5OB5LBOi?=
 =?us-ascii?Q?ULPz+VaBxU+2Y0m5jZ+slS+V/vcezilwJfFpTtPhY0UHY3ZB90thvAEJtPlp?=
 =?us-ascii?Q?pK24dYefSeKoDU7X6Esqw769HcruyyRzVu1rDQPyZHheVC7V3iHoTASzFfVD?=
 =?us-ascii?Q?72azOfy2C9ibifOhT6V8c1rXo28727cQcTKYkVXclwhfH6RJZngvatNAEZNs?=
 =?us-ascii?Q?uqFWgxHGHyEoKUaM7VgkT+h4IASqySmSciH8b8AGR2NYvVOvuv8gy3SIbhz/?=
 =?us-ascii?Q?hhemzC76bbHJYhrfDpV5EBIRnTQCr49vw0l4VtuaDpDIHf0srs8oh7BxNgY1?=
 =?us-ascii?Q?u2utOt0ty6DW4xRTC3fuKqRcY2PuFtZextyVr5Z6Hn0e62L2LK8ElZ+Uq/v5?=
 =?us-ascii?Q?yubKlWDCiN2+/uIH0yWhA7a2X2XnEop/xtjK5XWViXBfLVIW8NgISPie+rmv?=
 =?us-ascii?Q?QO3S4Kww4WSxLzmKtIJE6Z5yv8wrcvZc8CHxVTKPrTk6T/HfW8R0PlldwKhv?=
 =?us-ascii?Q?bavthkWrF6eINQZpckQZSBNrocTyA5kXuvrdARsb3SFRzW3gSM9GoF74LcFq?=
 =?us-ascii?Q?KoG52GBsk35pq/e0yW7IPs8bAQZiWWLu0ZNGhdJlupdeqoUiA1WHdswT4vTf?=
 =?us-ascii?Q?fChCl0IbmYsUaChwlq7ZYQ79ueyDwEIqv4BhFF4ZDZQ4n1uMmLLgdI8UZag7?=
 =?us-ascii?Q?GlHB/ThEeA2ct9Jtbgoc1qdx2eaxUFBTcaEvx2BuWYW3OT4jGCmTeSNsHeuu?=
 =?us-ascii?Q?yXkMkoXyN6fNGuvF2z+ga3OWZVZhA4/v3YAR3l3IUryI8HL0TXMujvC21vQH?=
 =?us-ascii?Q?hlYFb0tQ2b5QaT4LUQxRVtpQ65evJ/GplGHOPEpdi4qmlNFQeOUoajgNX2Qj?=
 =?us-ascii?Q?nPj/qWh8+zw4tbsXqIsAq/Q5NrRz4QlLLXce+gkKISRymkB856a8vFfRR4W3?=
 =?us-ascii?Q?LM3YXHwKj93bUjjAjhKpgyASb/57RtVueYmmdqZBSAeZq6MmfJwIqveCyL5T?=
 =?us-ascii?Q?splA84uIWG50LHgL6ijKHeEtJP00cA3rj85YdEjMqH4iyfbtbpooqXvpZmvw?=
 =?us-ascii?Q?cK+Wb3CEe4cm70QZUAwR4JcZRAvdpnLYLkT8ckJtCa/7MdkNRhCYMb0DK2He?=
 =?us-ascii?Q?vl/8oyuTpjoi+h5g5IzVZdGyBz7Sd6PsnH1eyaWdKxtA5IDLBMKEnk4cOAk6?=
 =?us-ascii?Q?gqZMI2Y/om7ip4RlEH7v83voT6clakYFxDQWakWFra4/m2O7pdVz/ztlODff?=
 =?us-ascii?Q?nhNqMJgS8xDIjPxKaP6LtXzc7TpPBiO2Jlek9Zir7MoPGNlt4kE7URkHNYY6?=
 =?us-ascii?Q?voCSh09BzBsARBiitkwWJHJy7i3sA2GMEgjb3BTfSuYOQgiE45AKOZitO7tG?=
 =?us-ascii?Q?gfQ0YJX5/b9llpOfMlFthueubHqW1qWcZ6tB2yqnB12PIK8rulGm4O4tXEC3?=
 =?us-ascii?Q?hXn8jbUyoNjPsfCcxIx3THIJsxf8wa7BcfxCII9zz3GJGmHEREGlrJXeuvhX?=
 =?us-ascii?Q?Oe8V4ZQGYc2zjjP68ZOOHXTyh8bj/vqHC5jl5OUX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9285508-32c3-493b-1592-08ddba5a2bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 17:51:00.1639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XSLj9TCVfKGMgeWQpJtHVafdrhhOgPCvbMLXEBPhBaeSSfNLWcvA9Z7pVYCkBDXJpQPUX/4zPhnUbdU1pV4XiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com

> In summary, I don't think we should solve the problem of correlation
> here, given it is not straightforward. I just want to tag that the
> hardware got an error while the kernel was running, and the operator can
> use this information the way they want.
>
> Am I on the right track?

It seems that Rafael has just applied your patch for taint with the machine=
 check
option. So you've got what you originally asked for.

If you want pursue the idea of a taint for GHES warnings, then create a
new patch that does that to spark discussion. Your case would be helped
if you have some data to back up the need for this. E.g. we have observed
"X% of recovered GHES errors are followed by a system crash within Y minute=
s".

If you don't have hard numbers, then at least some "We often/sometimes see
a crash shortly after a recovered GHES error that appears related."

There are only a few unused capital letters for the taint summary: H, Q,
V, Y, Z. None super-intuitive. Either pick one, or move into uncharted
territory of using lower case ('g'?).

-Tony

