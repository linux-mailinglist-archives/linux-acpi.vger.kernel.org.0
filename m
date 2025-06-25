Return-Path: <linux-acpi+bounces-14624-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C002AE8C46
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B927C7AB0A9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956672D878E;
	Wed, 25 Jun 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3AxiNZV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C61D95A3;
	Wed, 25 Jun 2025 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875798; cv=fail; b=s3hhrqu+82NlPpWiohFicxmlR9YePfnQwtlgAcNugI2/HjzvhSe7mShRHiqr9mq/WliRJw0WvNGAA/5NmD3+S3vgzIk39OclO9jT4oD3BPFPei1+lSITe3oRa+nIi3yja0yuUF1vgKEueSCrWDAw0cjgkgqgRHPklyLLcDk0BeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875798; c=relaxed/simple;
	bh=DzYl9dH/jpjRoz8rZcpb3iwYNURhiDon7vCXU8J7710=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WFzFcYLM8EFF7UfmfjreaR6/226PL8pagdBpz6hdreWd8vFb9bHyU6N6E5p9Dsxo8rj9RHTEok3LYFO5PY9ZzLZ8WElbYsMbgYIecsIXiFRGTubNlYIFbmnGI4ZuYgoBzIz/0vjwuQLBDU6XefVfp6ohCeW2O5yBtGSCz56N+sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3AxiNZV; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750875797; x=1782411797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DzYl9dH/jpjRoz8rZcpb3iwYNURhiDon7vCXU8J7710=;
  b=C3AxiNZVGoajH7t+4VEKoSEePO34PlVdgq5attQUWOScHbdIh9MCYfC1
   1GZ7HQcYryttf+hmvNejE/ADG1l80QAd94sAmgTUf3mqyh0yClIjkwXh+
   WXBRoe7BuE92eLUgGKEsgIPQ7NTrcwFO8Xykv/nW4mSdDW574ABp2qlLI
   nM6b+23LeAJOinAFO+PZccduGKFZ2R7/kPbmY/sBeeuI9jKi9Aj8yBL+B
   cddvJcjhRF1LBE2gtntt3+ng4O8gU4fiuWm9ULXPbmVJddrtt9wRRHcYa
   tFPMSFFAMwrsWP2mQogjPex9q+ufFlVWnqE3A/zsbk9Za0LdAwZlAG9FU
   g==;
X-CSE-ConnectionGUID: O/+MzEHoQm6aR+mt6LymLQ==
X-CSE-MsgGUID: rtvvZDWcTQu9AN9+mn0Gig==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70728825"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="70728825"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:23:16 -0700
X-CSE-ConnectionGUID: pD0GQI8NSw+kS5RmmKE99A==
X-CSE-MsgGUID: 96psp4tpRtmBBkBGOwuoRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="158053204"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 11:23:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 11:23:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 11:23:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.78) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 11:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfmS2oelMasdLN7eSOLfJmtXKlmloNteqmJ+py52p1u+28uaaohpe6icBZA+3hkwE1MmeHxGW1ociwcZuqgmTc9BB6ws27WOjMQJjRN7t+grb7rEou+juTffC+S44sCrqC2IZpxjmLEiLtKFcoWWr3VL8Mo+YecqfMUgzX0BGeQ+JOBhQEqy4JydMoctN4jCMcRs6aufXAelTyYZfqzTAnvKg5ay42pPzTXLl4YHqWKhXey3AQG6vFBjWiZgw+V0sqqHvTiJBUdHnSzIKsbr7prR+2vkZUbsLUVdpOPxuwPQACdJ4iYnneq2eh12uFGN2PLENCoBLDdNHD53w/T8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIoJ1LVnKwlWpPIm1sfNmOWNYzRMe/yOFWrbz0OJV+Q=;
 b=VdjZL2eblSDFVRJn3mB2LzufTfQAtuk0fpRoq2WFoRqJW6AJDPJv4PmAA7KQKR4pg2SRWWrGGQiGIl03JNmy8Q52tRByT5XFejCpK3l09JW8FX5NNvzNs2wBTyB+gzMV6+Da992YIvl5hK1lEOgNMgqwCQxzvefYi/0dCYo3dA6mr6yJs0SdAQSiKrHV8C5o5PaQWxFlqvoKle+qE2iVV6HNxCPRnyVaGQK2VHdbRhj8c5tUhmmAe6w6aLO3IvaLNrZc8CY9xEBlkXM7T2kx4hOKqpDZ/BzDs2C8K21bt9tPe9r0E9hIQ8TKwE5I3/5C0r9fnqgGACmSIU1bp8RmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW3PR11MB4700.namprd11.prod.outlook.com (2603:10b6:303:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 18:22:57 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 18:22:57 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Zaid Alali <zaidal@os.amperecomputing.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
	<james.morse@arm.com>, Borislav Petkov <bp@alien8.de>, "Weiny, Ira"
	<ira.weiny@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2 next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Thread-Topic: [PATCH v2 next] ACPI: APEI: EINJ: prevent memory corruption in
 error_type_set()
Thread-Index: AQHb5e8X7AfR5201gkmRDcUPGjQMqLQUK0AAgAAEPQCAAABPsA==
Date: Wed, 25 Jun 2025 18:22:57 +0000
Message-ID: <SJ1PR11MB6083603821632C25DA5D8EEBFC7BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <c71e7ba6-f127-4f49-acbf-20063dd26553@sabinyo.mountain>
 <ks34mfmv2vhwojpxlzv7tyordcjdo6zclcflplvs2wsl6gkbn5@3v5kguelmita>
 <757b5117-a865-4d31-b566-248048f87b29@suswa.mountain>
In-Reply-To: <757b5117-a865-4d31-b566-248048f87b29@suswa.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW3PR11MB4700:EE_
x-ms-office365-filtering-correlation-id: bfdc455a-4bc6-4f25-b9a0-08ddb4154f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mEQei4mym+jWWCxtbR0Wy0uehmkDg3fbjvTo6WEOGTz2dXaD8IiA7UjJ1r?=
 =?iso-8859-1?Q?DwW9AfkQ9EGBt8+q3Dxv108Y2hn+nooRnDtugw1TcWSEoFNjv4qWNu2tRX?=
 =?iso-8859-1?Q?lbbkGMjbfpkyvNpKEyhhEAqHwVaAJx7jrSeYfFxY2AkdgAcb7TwUjZqY5u?=
 =?iso-8859-1?Q?swq2Pskdl80cPzHqSyrhKu6lxnfo8x/UbtzqqHlPMtpi3xtNrBHBnVgEw0?=
 =?iso-8859-1?Q?SvkbVPe6l7TGbsVW4JuxbhwvrFLHvdoZ3MFXh34fAb+TCtLagq8uqFToHQ?=
 =?iso-8859-1?Q?J4w35k9BdZoWUW5Jrk2k1BeOHMy7YcNcpR4PEsLTq+vqaRQGG+5r0mUu1f?=
 =?iso-8859-1?Q?lAs0RflFRfsNIv2F+jiwm+NrtZzvVuidevdj9TT/9Ie6OcZy+VA/MGCOMi?=
 =?iso-8859-1?Q?6MHDsLPGTSpNYaEcMfOCnVCoK71O6EOBqEOxQw03PA3ACCBjDRaKtqrgCq?=
 =?iso-8859-1?Q?AhpKCkhIkvScQ1W2Cx/lwDwnPrncA0GAJ3RKQkkapkSPDXGRII6UR4YlUj?=
 =?iso-8859-1?Q?3uXFkdtTs9TMqDUdFcF25ehULG27ZL+QhW4wuA7HNQtzA2lD4/RPr1Dlrw?=
 =?iso-8859-1?Q?BIhZAO2JR+u/ac9gCczFGcuLawJdq/SbZMKvT4BydP/RsrVppm6z8AgzDv?=
 =?iso-8859-1?Q?bt+l1YIaLczF+Ki8Q/HBCTDJelqQd4nbXAqhjcN1xEdR29N5utpiu1hlAG?=
 =?iso-8859-1?Q?mce4JqB57OGqLURiicECzECGMS/TZLLv/ssq4w6CNoNblYmc+B1+7dxgUp?=
 =?iso-8859-1?Q?Ov43wSXRJsKThRNa9TikPYTj35v5MopfwsKYdGrIXHsd4q1dVmjdHhaWAr?=
 =?iso-8859-1?Q?XmCAWcyiJVr1qH1YDuzKerylRLgKzBkx4ubJDmW14pFFcre5nivx7kR9i1?=
 =?iso-8859-1?Q?6kLLentZ3KoFXPkYb2bi/Se/FmEHPvQniSJhlkGK79HPyPTS3+icDEBBrb?=
 =?iso-8859-1?Q?mqqgySWrD0Zv6BrYJzMfCjpLph+41/c2HCc+dePyo0gURFzewB4dl9/p7D?=
 =?iso-8859-1?Q?C5URyMWoY7Y0n6M50miIfx7xOAgrBTpukGelzIZ/JMbxbL/C1ELXlBdIoQ?=
 =?iso-8859-1?Q?oGrCUB5eFlKdFJ0MKldmr3srL/9ore1MPPkndHYToVdUvrUBeoVdgYPTNf?=
 =?iso-8859-1?Q?VyE27iG5l28UOQAghMufZFxhHrDVul2evuW/b0ZVcjUeRCfVy3661tkht1?=
 =?iso-8859-1?Q?h4jkmC0RNQb4cNKTKJ9lAsZlcx9Zy6NkvqDM7ZY1h0ZycKCnprne7uzQ7q?=
 =?iso-8859-1?Q?cUZ+/jFWL/ohYPFUf8kTi+GwCosmQzKYbjPGxHKWz4VsVNAyafzgfDCxEK?=
 =?iso-8859-1?Q?ajEVOBC3NUUgH0Y6mhqV0FoAh94I6wwhTmxuJlo7KAwQyroCptoP4Snz07?=
 =?iso-8859-1?Q?0Q5bRWE9G3YirXLnR3eLQb6VuJRewRzdnmVo9FLw6/dzDO2p5n8lf4gxul?=
 =?iso-8859-1?Q?V0QPFKQlB37HX0l0i6k/ojIBYqcJVfvFDkkBtUrMNAMOjUdUaIDz3qNQBX?=
 =?iso-8859-1?Q?TDsvqJ/InmZVpCzzoRkaF6bEUkUOvTKyCVPBf/i4pDHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SMSaFj3ePEsqFegUHYVWXzp2ZE1ALN7MuLVGJpoRMuqJRTPb07m8rph1OB?=
 =?iso-8859-1?Q?TobU9O8Ogg0Lo8wDx9iUKdp/qga/tooEAw4Kf1yQw1ygfAYcvySWlq0yyH?=
 =?iso-8859-1?Q?xzh233j4XpTRY/XHgNUBoUNOoF74YkaqaQ5xzcUx3UTALp+q7eBa7pmxWb?=
 =?iso-8859-1?Q?cDUw133UtdOYhlrEUUefRCXYusbtqMXoI4RItR3ZXbl5XavsDoyQHkRCji?=
 =?iso-8859-1?Q?fKc6hJgZegzHSsClC3mr6Dv6GUoT8OKoLxjrHKd2cL8uPiVOAaYZhmS8Q6?=
 =?iso-8859-1?Q?wKDMWQIWpyREsniDJpK5MxfzKNH8h4OpFr2MBI4niRQ6h5aRH73pV1BeZu?=
 =?iso-8859-1?Q?YenBiW+j9NtmMZSJ9lKrxdE4UK1dADs1cH2P37laZqS8wnp+lMCGQCXGR9?=
 =?iso-8859-1?Q?AFScikNAF5/ux3SzycE+UYqbjmgvyFV9/eLslurudmvsS2V3+8kJG7GqW9?=
 =?iso-8859-1?Q?FHTe/lftFzZvl5AjlHi824JncPiTFMwGRkkZNsR5w5Nc4Tez4P2db6YS0H?=
 =?iso-8859-1?Q?9XhEXW3v6pu7NrA7CrWrNUGTMypoVFLSfGuMPIftkm3zqg4Zhln2cw3YS6?=
 =?iso-8859-1?Q?T9mA5SJA8UNyz8WyZAgFaoFa6ArOrZFHokRXYWkAUDMUf9jTChebXTTqkj?=
 =?iso-8859-1?Q?FiboZ5d+5HDiArUDCuZHTkEWsf94zeONFhf7jL/cT8GKA6biGBb4mj7vLu?=
 =?iso-8859-1?Q?W6wJn8FzgCweB5s23ccN6vZeoqmm0x6qymhnetu9NyvcF64SgenRtG0UAH?=
 =?iso-8859-1?Q?hEFpBC6Ddwgxj3MLz0fEvgls6TRkwIIAxA3pD3DCwX1vzNdjCeJjYd00Io?=
 =?iso-8859-1?Q?h/n71oGjRWQ/4iPRJ5b4tQcIEek3UuPz38qmG0kPJPUxPqBMfAh5EruHOY?=
 =?iso-8859-1?Q?GxY1X9DQsuXJMMNPsP9dY7mTTImPa064zDBosKBrZhA+/rzbKy2FJzsUer?=
 =?iso-8859-1?Q?qBsAsbRbzCPnNbUGF2WYOZxzNMTayGPqB7YcKod81xu54FliHH9DAX1s+g?=
 =?iso-8859-1?Q?M8Za1G/0hNTaRp/wshv0Rh6eIpdccXkq0dh8IjuF8uK7SyAquXASdZErI3?=
 =?iso-8859-1?Q?VMCgIpDamV81A39y3jqnsoNrepYy2UFY1vaOACWr3ziataV6XV1LHj+4iI?=
 =?iso-8859-1?Q?GFDUmr1Cp/LmHRbjqEIHwIdE1+HQCbWu4Gr5RxXrtr0F2S3e0wPwG35OM1?=
 =?iso-8859-1?Q?Vr0sCcCN8Mo6MFgJENK5BrLWU01Z/PLQo6BiRJrGbcdYIWLTlZdjQo8uIF?=
 =?iso-8859-1?Q?w/ehBg8qpe5t6ff2+5Y3DYa66usX3C90k0kEbHolKUVjM7inLVKV8gQll7?=
 =?iso-8859-1?Q?ZDzIVqM5nL5P28X9r+kJWBsMKrn1AkOjokg5L1by/ySyAa9V9Vm3lLrTP4?=
 =?iso-8859-1?Q?NOkoeKl6qTs9buQ8xFeBGMlmQ+ju0f6/fsgBV6WXrM73g+dJe2uGPPez5i?=
 =?iso-8859-1?Q?yXl4yA1NKw+0LGgvE6Fww8MA4/6QFMQxbYuKJveGxWPz/UoSyYHruyP+aa?=
 =?iso-8859-1?Q?yTRtIOtByblb0HQ7/D5vZsgO07k196UK98z3v5vH2RTeZG7TumktsMoCe0?=
 =?iso-8859-1?Q?DVIlQ217x+G6czFg5pMJ4fZQS4Q/TEkePA2onVuwuENSyt7V3icCbA8DeG?=
 =?iso-8859-1?Q?Zu6k2ddC9QiFmdr/0MUHOFUdCu2Lp9M9Vu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdc455a-4bc6-4f25-b9a0-08ddb4154f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 18:22:57.5880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qecKTRvZTHR6nPm+f2a7tnzgCdnLuEmn+s1X/4pnnIQnXOV1ImJ0awR3JwQGz4eqA5dn4BGmWq35LrALfZx6pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4700
X-OriginatorOrg: intel.com

> > +	if (count > sizeof(einj_buf))

Why not:
	/* Leave the last character for the NUL terminator */
	if (count > sizeof(einj_buf) - 1)
		return -EINVAL;

here. Then skip the min(...) addition below.

-Tony

