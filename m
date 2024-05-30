Return-Path: <linux-acpi+bounces-6103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 030EF8D4269
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2024 02:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E4FB22CB4
	for <lists+linux-acpi@lfdr.de>; Thu, 30 May 2024 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A428C06;
	Thu, 30 May 2024 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYMSZNaR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E08814;
	Thu, 30 May 2024 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717029312; cv=fail; b=PHQsvies+nkzV33kTPkjjswLpOOAzDV1/5Z0kdujkfNV6j9UrwXrrGPn8+eiBAq4xWg44VFLA7NI2J5uxorJWvoh8zhWY5AqR/HBaW6binnNRp+1gFXCzMMO63SBP2gG1XgDXX61Vh43ARqk35P0GuUmREi98bxnHQW/LIn9F7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717029312; c=relaxed/simple;
	bh=6GP7LcDzl/QIvSbWC0iHlzbIo/6uaHLq+ugmvghoL5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJ3PIp3uZHLRdFUr1n/F6F7qNJU6M7HdBDpM/Qh65dWDugD1EF/eHSopKl2+loy/qTF8UYE0q4hPxx64RPopuQsu/VECub3IfMJ8Lu6DohLc9FFBgMrYEqqmonJf4KXUap84xFiwZgAUMu2GEF137/WGEtN66hWYMZU5YCWpDK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYMSZNaR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717029311; x=1748565311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6GP7LcDzl/QIvSbWC0iHlzbIo/6uaHLq+ugmvghoL5M=;
  b=CYMSZNaR849zUUm6SLF5/hbuT6zdwojzbYkJzdSZjqMzJpTGOuKqFolF
   aBS/EpSAB15UhzEYAwQ0LrQJBvkSB9elpaDONpHG8WX10an9RUtmUL6Lt
   07C/xDtjVpiIna24A2g4mIl8QsPK83hP+ZOBezVenfriUg40Qm+iOT6u2
   BduI+WKJafb+CVyQeom9mnJjI07JOjVjlNo8hEoUal0LVQNytjWnKE7GA
   bj5gpD+GrDoBOZ0VUvd8iA4vLw/fNlAUBVcKKreeiVywdJuC1M5uufAR/
   M9Yw8jd8xKMFC2RbhSRp/Hgobk3INMmpHtw9n7GvlamGt2Fs5ZWFye9/r
   g==;
X-CSE-ConnectionGUID: Jtj7JFi2QYqKMtvIYM4jgw==
X-CSE-MsgGUID: a0c45R4QTjyIdZ8loUSbNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13323999"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13323999"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 17:35:09 -0700
X-CSE-ConnectionGUID: RiqqHjBPRHmLpV1CjcFCRg==
X-CSE-MsgGUID: PDKKUw7kQ160xQHnIN7U4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="36167246"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 17:35:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 17:35:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 17:35:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 17:35:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:35:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQYr0WsAaPqGsiX14bOQ3RWkFdaWQPyMooBmY6vZlKiftO9BcbxD5UH+XpamA41WYaFNoxDWto8tF+nLwcX3IuuzdJlaqydeF7kKlnhZ+78fFtXNMSjBoV6vpA5zv/QUhC1Z4NiUT3AkzMfTRrtKpPTAWzEwEF09Dl67WgVbYDIwhw3wiFu2YgVzdIIKG/VrFfDVDp2zrHzGdq3yKIaGqxzy9d12XNtib9KS3L4OBHvwB5HFuvhIXhFMOAB0VFzhR0pnuApGWRUas8ItWOXxWYLkTBaskGK6JwC8702NRSnSvthcUK/p9xeWrV5NBsrpKVaKN0ogSPUsYkrE/OQFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkG1VRCMi14BpWzlBZFT0l6LNUgCwtKNagSFzp/Hhjs=;
 b=l7kw5EGZTIMRNW2Dq9fR2znPpcJKgxCOn7TeBf02GpKXgj2OAq+FtXxQMLkrwYCTjjbdoRUrpviYv6mk2MjKNGYa0OmzAdIwk4jGozfk1oB1qbGKgmQN+tt/Y+IgBTcKpbmdnuIbPxrwod4SeaPt4UxnqqKJCI+xdyzHunhxYOSpYWwC7RrEqyUQyvNIE+eJYxTKB8TzyPv9MtFZhfjKzl8Ups9V27bq6lqM92bJsombVgz9x+AzXv6sCK/ZWlbvFdqJQMd52ijUMRLi7XpHnL0ePglzGgHPyRGokfJc4Hg8uyBdvb6c4WGHX+fUFm1pY3W728OTTosJ3w05bZc7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 00:35:05 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::20f8:8626:d842:9ba3%4]) with mapi id 15.20.7611.030; Thu, 30 May 2024
 00:35:05 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Genes Lists <lists@sapience.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Thread-Topic: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Thread-Index: AQHasNtEdHvJWkWu6kOkckIV4/5Qy7Gu8DDg
Date: Thu, 30 May 2024 00:35:05 +0000
Message-ID: <MW5PR11MB5787C81ABF0C9FFF5A17E4888DF32@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|SJ0PR11MB6623:EE_
x-ms-office365-filtering-correlation-id: 4802cd92-1609-4aef-926c-08dc804059cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?lDoiC5skQKa7VK0W89YaScCvGppXqXAB3daxw6kKilyZ8mlGIM60Upn+3XoJ?=
 =?us-ascii?Q?J5foA6L5EWZK2SpwURPCQhd/zympj5f+Ti/0UptjfCCy4Dqk+6xeZdEfOJqG?=
 =?us-ascii?Q?D6lqz/70/lmN5alsNmB6BjY77PM+pFsrZPpoRCLWlJFtqg55ZWd2VZuqPVNd?=
 =?us-ascii?Q?KJzmV8Nxca1IQj/ggqELYCMftZ9feej2Zn6MDBF9QGLNrnuDER5OMixaGsYQ?=
 =?us-ascii?Q?RU933ciE3ITgdsqrkxB18H+Znfeg+Zgsu8Yuw4pEHfVsyteT/H9BU89Deiue?=
 =?us-ascii?Q?hIVn89kuRNYfQ8bx8stfbQ6zVfNb124xlcLqGsomZnyZ6mfciGWrJgYninfg?=
 =?us-ascii?Q?SMVgUIC92XPgAGjzOLT9UUL3/a/jKqyb36cmfQTPAFCm6EmVwpHL1jWuYEt/?=
 =?us-ascii?Q?MHMGRYoK14JKy/hy1+QwzgkUq1OhFCTc8+G/qM6tiw3GVBzJxBFt+fqjb0s4?=
 =?us-ascii?Q?aqLNEj/8lX+QXX6SZz//WiYlle/ukTp1MV6Aovh4zqsJdc01TrKARBy7Ne0F?=
 =?us-ascii?Q?Fg7KGpQQCaRDqV1TjX3imsHeZL/Ml1hYwj8ZW9H4605YwIlLnFXuCcyao4Ii?=
 =?us-ascii?Q?pX806+Gk2FTXkpqs/zXcfHnCPj44VuDZIjfnSmEEWcOI8vmAhkPzoCvkC9mI?=
 =?us-ascii?Q?y0PjiVI+jvuHdmbfMDiznbcjqFVWA11C7o6DOdm/h/GJ7bh1lqucWA+gmynA?=
 =?us-ascii?Q?JHSJ0SBc61CLburHcsN0BQP5g5nvcJgZh9oQ5eNzQw+xa1VlXOyEXZ4h7saf?=
 =?us-ascii?Q?0p7oVMyjT4XlgTNCzNWCG8giqJTd9puq5gTwpKtePLXYyzKt64wA2ro5r86K?=
 =?us-ascii?Q?0P7H+IpSfFihfbKX6OQCwNKl5zaZ15hsjRfF/3Px8SVhZJObihi+8IBhuoTK?=
 =?us-ascii?Q?k9XzYULVPTMto6sDsvCMYA7f+tHdu5rMKByhsBMthoHyD27Kcp1txC4tQ1oU?=
 =?us-ascii?Q?gI/3K97GBP4NOuDTzIZt/+K60mO5LDDo547Hk5aQiIhidMZgvf6Csc+IKnw1?=
 =?us-ascii?Q?OmDt85pqqgSl2IdGg6U5O3PXm8mCkJ4efnThuYFWyko52A+wcy3mnASrwqJK?=
 =?us-ascii?Q?EcKbELTUH+2U9zO9hLJU8tqRAuDQfiS5gJwRc+5Jp0k05AG50TsIcH++V0dm?=
 =?us-ascii?Q?0KMhkTh45DVZ9cwK/R3R8lyiHAPo/pQl81t3oR+MoUdQcVtJHbWvBYLQMcV/?=
 =?us-ascii?Q?oJqhQ0YvfqgjXtlxEXdam0XKUw7ZEa5KKJSx6EfjZVjY+7fitpdqHJZ9oTdd?=
 =?us-ascii?Q?8t5Hq1fJygZWr+KU/OEsDvBZfb5BiQCJnxrIXkYl8xzTa/f1H6+bX62OR+B0?=
 =?us-ascii?Q?W1nlsItDdXAPEN08xsQmDgQy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wX7Q1kDIWEuxVT96Pkc4BiC6eawury/MYklBd2PXigHKGUMPfcwO+zJxAkr?=
 =?us-ascii?Q?PH6+bMh3L+geYbyLXKDH1Sr/0KwU/4zErKil1cAUdE+au/Y0lOjZps7AQtV8?=
 =?us-ascii?Q?ClEjGXw2+1Qj5VAfqpkPcFEjk5i5hPXWkuWmpzaMTNBLMopJc7FteMtXAyYf?=
 =?us-ascii?Q?Q5iTW1q7aEWRfBRhHDVuuUJfSWTrRn/oxCznAJoVF1oXdypBNjdvgpMXSTzE?=
 =?us-ascii?Q?sl/qzYhEb59Og9/cpqEaYX2m9ChINYuBOHLIKxLwO0Vb7ra+LDZZnkg902tn?=
 =?us-ascii?Q?OSnet8egU2r5fw1OPqIRxKHYo0bRZfVyzhJcHuGFtk1AGmwdqLL6NR/PNEZT?=
 =?us-ascii?Q?/ATYsxaEffuMtses9yPXDcJpyE6TYGJUNr+BSuE0Vc7wvuEEIFhli/HU4A9d?=
 =?us-ascii?Q?cYANVfhN4ZVUS/6qNRGTDQxuv7SUNdoIEtYloXmaRyhnPqvavsZijuyiN52l?=
 =?us-ascii?Q?Bgi7yiCjzuCNohNst0Ei+QCEdO6ETYMvPKL2V2G0aV1bA+mtKdPMD5i5/fux?=
 =?us-ascii?Q?IqdvR3g375L4jT8u7JqIgPDkDpd//DkBwgu8WbrDm5D8BkeN5YuWZcYNIbXq?=
 =?us-ascii?Q?pjQ/OZyJcBbdpkY9l8g5XAAlkbc/eMvHdqTf2T/eX/VB8n6ygy0VxHd6z+I2?=
 =?us-ascii?Q?Xr3O7SpdkMd/hlCSsltqEjd09S4XlM46MGp4hujpC0fdgdUK+D1cLZTHGCSi?=
 =?us-ascii?Q?Sp75IOVmME+cGi2z1asWV+HtN/UJ2qThNNrCzNmNbfMXvXG6/JAugdM88MrG?=
 =?us-ascii?Q?2SJjQIWfW+13tLmuVKO7FLZds2hrKFJqBrUqhyp6lx35ae2xq8YR2uw78KkW?=
 =?us-ascii?Q?HE+G04Lnbudf2TwNuZIzqZacOjRzub6bh7Lwqt8fOgwosR2BYxx/HtEq0xaR?=
 =?us-ascii?Q?UisV3YHBLhTGJfVo98/5tybMHhHPveKYROLIYAhr8fXeOws5Tl+dqVw50Yga?=
 =?us-ascii?Q?kC18dPAa7/Q+6fw5y8yeg0kXjpqXDaOF+/3ji+3PaeBfiig74DcJZU7QLnya?=
 =?us-ascii?Q?yCd1a2eNeZ5MB601I2D/+QN3AmyO7p7npgj7h7gmSPq9jCD5nh4F5mxQlal6?=
 =?us-ascii?Q?/OHCgAXQTUYoZpUMOZ1YX30ucYkfI9x1prb7p3ZA8ru0L2Sgqi8FgW+rVcvH?=
 =?us-ascii?Q?TwCdsfqbXODsrPZGD7sW4cfmuVKiRhpQdJrpVSrH5W5Tuaq+cOgy02J7ZdG3?=
 =?us-ascii?Q?KMtkOebzgAh9/mv7YlNvTWwSDsPPzS3RqAWF8oAvKmGg/AVkhFY+4vVWrSK1?=
 =?us-ascii?Q?17QV+N8Slk2+kE0wFG/ETdM9vn4icCM380Kb0MzgRMUMj4XrPicnim4VpSYs?=
 =?us-ascii?Q?BxLgDEf9jpa3ipT54hC66xLDNqGuEuWBg9udZu5XY9R0slVPpveGL0dCgt8V?=
 =?us-ascii?Q?JEhmI5wM08ada8xLGJcBkhCmXcNUglPi4iicPKp2U+greSHmJqMzPF5rS9WZ?=
 =?us-ascii?Q?oJssJ/4KWEip2qAkSBwMDZ94WI/Puy+ilCZeUChL+RGAUuQ5uwXuPDJTZN1M?=
 =?us-ascii?Q?qQMKDYt4c8GV31Gjzxps8uPYX+RNDAFAcX7BKeIaOfYp4fab5jeeDfdMVE+j?=
 =?us-ascii?Q?rOVpE1N65COcFY04cn/M319kuj96feU+64CxskEy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4802cd92-1609-4aef-926c-08dc804059cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 00:35:05.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQUwraSMehpvPesk6Sx1oFFMLm985gEgpZWtrdZ+FIhU12Q1nqpq9y03OOU6nYbK/PHiVUdlxP/eJPgr60PNXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> Ignore camera related graph port nodes on Dell XPS 9320. They data in BIO=
S
They -> The

> is buggy, just like it is for Dell XPS 9315. The corresponding software n=
odes
> are created by the ipu-bridge.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Wentong Wu <wentong.wu@intel.com>
> ---
> Hi,
>=20
> Could you test this and see whether it fixes the warning?
>=20
> The camera might work with this change, too.
>=20
> - Sakari
>=20
>  drivers/acpi/mipi-disco-img.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.=
c
> index d05413a0672a..bf9a5cee32ac 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -732,6 +732,12 @@ static const struct dmi_system_id
> dmi_ignore_port_nodes[] =3D {
>  			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS
> 9315"),
>  		},
>  	},
> +	{
> +		.matches =3D {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS
> 9320"),
> +		},
> +	},
>  	{ }
>  };
>=20
> --
> 2.39.2


