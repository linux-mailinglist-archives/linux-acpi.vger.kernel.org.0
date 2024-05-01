Return-Path: <linux-acpi+bounces-5577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4018B8EC6
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 19:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52061282C3A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 17:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E917580;
	Wed,  1 May 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="VbSoLtgb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD924175B1
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583234; cv=fail; b=l0aEr68xstu9b8QhtbA4vyA74HBLMPHnreuSg+mrP7gAcOQQ1+V6eHYcNwnF0AOoFR2DSYSGpKZnBhk0hSSKkg3vCNHrMAQFwQ1lxHd76RT8Cw6p980tahOlxwLSQ2u1A/J1HZr20KjqHOlV5Vy8W0WUZ5fdVk62jZauB7KRRe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583234; c=relaxed/simple;
	bh=BlAI0zp5d7RRHczDeLwNbPcDltMgKelIW25R051AdxA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mXDiMtiHFCN3B+smxqS2YViXetgEoQkOwsu0pUrNidG1iFXAxqzWb3IZKVQoV0cUuNarh/38Bp2SMmcHipLhH03s3vFZAxs+FY18G0N06CASlWnYOH+Rp6B+OTG9hbROVR4SCnak0xslORAgRj+8G4WO+OTTWmol6U3gLohlwzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=VbSoLtgb; arc=fail smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1969; q=dns/txt; s=iport;
  t=1714583232; x=1715792832;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=lLddkSEd0wptklyRltggqrbPVe3OligtiRd3nPVSxEo=;
  b=VbSoLtgbIEiT9WgG0yyM5+0TsPqcQuRmeUFofrOuys1KcNaG5wgRDHH1
   z4dnq9q9rrTO3UQtiV6scKS8a+2gVFK0QkZf5jPwLCjrLOMGQHWMnzy9F
   E122hm4gQSpYAm0mUJPiHQ45IyCyQVGG0DwNz8QhGEaixKgp9l1CHDCd+
   c=;
X-CSE-ConnectionGUID: 47LFDpuiSRGFUGQmIsFyGg==
X-CSE-MsgGUID: cc4MfTzgQMyvZNsW7RoEGQ==
X-IPAS-Result: =?us-ascii?q?A0BaAQAodjJmmIENJK1agQklgSqBclJ6gQkSiGkDhS2Ib?=
 =?us-ascii?q?J4NgX4PAQEBDQEBRAQBAYUGAogsAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEGA?=
 =?us-ascii?q?QEFAQEBAgEHBRQBAQEBAQEBAR4ZBQ4QJ4V9hlwWZxIBfycEAQ0NGoJegmUDA?=
 =?us-ascii?q?aw5AYFAAoooeIE0gQGCGAXdf4FIiC4BijwnG4FJRIEVQodrhBOCLwSWcYMzg?=
 =?us-ascii?q?iyJQ4FRHANZIQIRAVUTFws+CRYCFgMbFAQwDwkLJgMqBjkCEgwGBgZZIBYJB?=
 =?us-ascii?q?CMDCAQDRAMgbxEDBBoECwd1gzEEE0eBOAaJd4MVAgUhBCWBdYEOFoJ9S4IJA?=
 =?us-ascii?q?oJsgXgOYoUkHUADC209NQYOGwUEH4EZBaFFBmZHGTVMeC0/OaQfoBmBPAqEE?=
 =?us-ascii?q?6FiF6o0mGIgqDwCBAIEBQIPAQEGgWU6gVtwFYMjURkPjjmgSYEzAgcLAQEDC?=
 =?us-ascii?q?YpoAQE?=
IronPort-PHdr: A9a23:n5deyRWpx4SAaUN3OlADyIzztd7V8K00AWYlg6HPw5pHdqClupP6M
 1OavLNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QS47lf1OHmnSp9nYJHwnncw98J+D7AInX2s6+0/uv47XYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0BbLr3BUM+hX3jZuIlSe3l7ws8yx55VktS9Xvpoc
IronPort-Data: A9a23:3wVMkK8JAa2k+sJqLiOJDrUDgX6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 TBMXmyBM/jYZjSmKoxxYdm29x5TsJfWxoRjGQI9+3tEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4utyyHjEAX9gWIsbzpNs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0OOYBVaTqdGS9HfpXUbD+vBPF28nEoJNr46bAUkWn
 RAZADkJahbGjOWszffqDOJtnc8kasLsOevzuFk5kmqfVqhgGMuFGv+bjTNb9G9YasRmF//af
 NcBQTFudx/HJRZIPz/7Dbpkwrz33yGvKWMwRFS9rqFrxmbv3gNI9anzAvzORYOwQuh6pxPNz
 o7B1z+kWk5BboP3JSC+2natgPLf2CrwQIM6CrK17LhpjUeVy2hVDwcZPWZXutGwjkq4HtlYM
 UFRq2wlrLM58wqgSdyVswCETGCs4kE4dfZIDuwB0i6j94Xt5ieCKHkrQWsUADA5j/MeSTsv3
 16PutrmAz1zrbGYIU5xEJ/K9Fte3gBLdAc/iT84cOcT3zX0TGgOYv/nR9JnFuu+icf4XGC2y
 DGRpy94jLIW5SLq60lZ1Q6a695PjsGVJuLQ2ukxdjn1hu+eTNX4D7FEEXCBsZ59wH+xFzFtR
 kQslcmE9/wpBpqQjiGLS+hlNOj2vqrYaGSM3g82QsBJG9GRF5iLINE4DNZWeRcBDyr4UW+Bj
 LL74FoOtMEJYBNGk4cuPd/tYyjV8UQQPY+4Dq+PNIUmjmlZfw6c9yYmfl+Lw23oiwAtl6p5U
 ap3gu7yZUv2/Z9PlWLsL89EiOdD7nlnmQv7G8uhpzz5iuX2WZJgYepfWLd4RrpnvPrsTcS82
 4s3CvZmPD0FC7yhPnCLrNJJRb3IRFBiba3LRwVsXrfrCiJtGXoqDLnaxrZJRmCvt/09ejvgl
 p1lZnJl9Q==
IronPort-HdrOrdr: A9a23:O2/e0q13ubRPsQrl4TSLDgqjBfhxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6Ky90cm7LU819fZOkO8s1MSZLXbbUQyTXc1fBOrZsnDd8kLFh5RgPM
 tbAsxD4b7LfBdHZKTBkXSF+r8bqbHtntHL9ILjJhxWPHhXgtRbnnxE43GgYzVLrWd9dP0EPa
 vZzPBq4xCnfnMaZNm6AH4qY8jvzuegqLvWJTQ9K1oC8gehsROEgYSWL/Gf5HgjegIK5Y1n3X
 nOkgT/6Knmmeq80AXg22ja6IkTsMf9y/NYbfb8y/Q9G3HJsEKFdY5hU7qNsHQeu+e08msnl9
 HKvlMJI9lz0XXMZWu4yCGdmzUIkQxeqEMK+2XoxEcLkvaJAA7SzPAxwr6xRyGpqXbIeusMlp
 6jkVjp7qa/Rimw4hgVr+K4Ji2C0HDE70bLVYUo/idiuUx0Us4IkWQSkXklYKsoDWb07psqH/
 JpC9yZ7PFKcUmCZ3ScpWV3xsewN05DVitub3JyzPB96QIm1UxR3g8d3ogSj30A/JUyR91N4P
 nFKL1hkPVLQtUNZaxwCe8dSY/vY1a9Cy7kISaXOxDqBasHM3XCp9r+56g0/vijfNgNwIEpkJ
 rMXVtEvSo5el7oC8eJwJpXmyq9C1mVTHDo0IVT9pJ5srrzSP7iNjCCUkknl4+6r/AWEqTgKo
 GO0VJtcovexEfVaPN0NlfFKupvwFElIb8ohuo=
X-Talos-CUID: 9a23:TS6dzG4zXX7lk7sui9ssqBEwNOw9b3zm9lj+HmCBDEdyZqy6RgrF
X-Talos-MUID: 9a23:Yiz+fQUHiKyiTy7q/DTn2BRsCNVn2oG/FnIriqpZgc6pGhUlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 17:05:42 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 441H5g0Y014129
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Wed, 1 May 2024 17:05:42 GMT
X-CSE-ConnectionGUID: fmQWeGhjSF+UMGaRMA2yQA==
X-CSE-MsgGUID: TrF2VhyzQaOjLyzU0NVFNg==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=balsup@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,245,1708387200"; 
   d="scan'208";a="28909512"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 17:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVFein1TyOHBkoBR5QongUhupA51Ua6NAvkAxwz1pMwGGfZejS58EXIJ/yjLD6y6JDMFwP+Kqi2K1SIABZxrziV3WXowT3YqNycJG8igpel8u6XldTXftM1dg/to5BCuRELe6OyOme0F648/XnhZknijBbN6rWywUjPrPGZp1bf+5kSTHfRot4s0vVQJ7/U6sdvskMhdv1vOunA24/v9qbAucC1u9F8vFa1ZWgJiq/VSo2UfUeBczAdfeTL1it9N3+8kn+kvxBX4UR3+8dE1vZ2nopAVzsenqf0Jhhozo3OM21TSKK7K0/C3mvExn/R+ZInWUmaEbI/03VJMq3pycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLddkSEd0wptklyRltggqrbPVe3OligtiRd3nPVSxEo=;
 b=iDJdVPlF5lsskIMM/xBq7Tzuv/mfAiMt0XJNEGOXfb0QzBCVCmNMZ/QCNGyomnLroMYBT6vtcAFnv+2MYS8JQfqtx9hcOxB3JN5ON7uZ+uVJgrHX8DQyOXoGYKt0qc2uzOkC4zDbh7KPM7mROSxAPgh5vBlavhz5PK6srzQNbmY2DnhniygNNmEZedqRd0MYvVb6OPFTQ7B8fwoUnKvY1fti6QVK8Eq9hUgETJRedhUzb3qBrF/JK8+PdP1yNnj1gJlJIydiLeW5WzeYKmB/efWT+5XyQqNISbMX26OP/Aj4luK9Eiyv2/P/1IvI8dYqG+4ToFW88dmpNVmhHArb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 17:05:37 +0000
Received: from SJ0PR11MB6624.namprd11.prod.outlook.com
 ([fe80::1d1e:a93:b052:46ec]) by SJ0PR11MB6624.namprd11.prod.outlook.com
 ([fe80::1d1e:a93:b052:46ec%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 17:05:37 +0000
From: "Billie Alsup (balsup)" <balsup@cisco.com>
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>
CC: "Billie Alsup (balsup)" <balsup@cisco.com>
Subject: 32-bit versus 64-bit ACPI tables
Thread-Topic: 32-bit versus 64-bit ACPI tables
Thread-Index: AQHam+WU1TjvEkAO70usXG676rn9lg==
Date: Wed, 1 May 2024 17:05:37 +0000
Message-ID:
 <SJ0PR11MB662464447DF707057BF43F97D9192@SJ0PR11MB6624.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6624:EE_|LV3PR11MB8602:EE_
x-ms-office365-filtering-correlation-id: 3af80ee1-6744-4822-3254-08dc6a00ec34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1XWh2ec4yI9fMO2EAH6tpG7QXz/5i44sNgnqFXvE4HiH0xIxp5hR4QK167?=
 =?iso-8859-1?Q?XMX6oybukkfrMe0+b1GAPB0h+0NokVJagb0LFbpQPg+oxJatk6Vg1aM10W?=
 =?iso-8859-1?Q?RSo3cZrf4chAnhKRt+UifU0Ytt2pw7KwBeLZOuLtfpA61d4maIFgXG8F43?=
 =?iso-8859-1?Q?aEMOlAdwJZmbpZ7JsAc/80HjHhPSShtKBCC73zY1zKXUuEw4XS6pvKK52j?=
 =?iso-8859-1?Q?gytHYIn99mqCjRuN654YbxjJh+v//+OWZMGqmvOwYR6vt+aWH3dajaYnVV?=
 =?iso-8859-1?Q?WBm6RfbPVwhp90bqTFZtebArv0EjPoPFIqJU11qGP4JJ1Re5fFN5s40DV9?=
 =?iso-8859-1?Q?HWDTQYDon0BLOHty4lkEtL37pfQeF078ksJsUf+DdATOIvpoiuIa4OpyxA?=
 =?iso-8859-1?Q?KL4JnjWD4W4o8xkgZ4PQWL26i2uUhWF755lr7vf2a2Zb1sV6BQJBwDR8sC?=
 =?iso-8859-1?Q?OxJ0uxrT3lx4r7kBHtlk143M1kgeYePGcooeFnPaVGJh8WqF/kyXOXzLsY?=
 =?iso-8859-1?Q?CHH1Fex6aHMNCeeLr7DFuHSmzeqEI3678rkYtNjEfrxumUU23urCueV3LW?=
 =?iso-8859-1?Q?Pt1I58akck9II7FUHSnTCQoBBKKCTC5hsvxBvPAMe46deAw4HOwNOJD1dm?=
 =?iso-8859-1?Q?fEISL+VHLvrOLE6Py8TIGu5v1p0oxYNEQJ6aXyclbz+JeoZJrzhFdmWRee?=
 =?iso-8859-1?Q?2HrTV5Y0Ez1diG1BWrb2YicWlWjI5BuWVXHc980V14Lg7ZAz9AC4VKdkOs?=
 =?iso-8859-1?Q?O0pBcGf4JJqk3PkjEz/i4lWyFJE9fIynBp575ZhMQ8wOM84+/8taUBzCUx?=
 =?iso-8859-1?Q?fYwoIlyle6bIqm5ByLmlzI3D+PqD7pIKn3N30Om/5Xy8aSR4TOKRvb31ac?=
 =?iso-8859-1?Q?Z+nR8rksUMvJLKGuglgfOHBpv5yEmwAyz1DUoqEynKIccAz/cqeq5n6ALx?=
 =?iso-8859-1?Q?NHJyUSEqXCzAP7gpjOPz7gKTWxCYalMiHklgkUbGE9ePK/LUv55t3MvxV6?=
 =?iso-8859-1?Q?OErIZpEqgio1KpHdxDw02yFj7mdwGhmdIGJ0BVSGLakGv454n6q4rLNgQ2?=
 =?iso-8859-1?Q?m8W8/lSR7tPnSIyMcwGzGfD8frlne7oywgdDXt3iJPzEaXBUTiVqTF3/3x?=
 =?iso-8859-1?Q?LpSfv6c0euKiMqSnbci2ITsd9hSR7EeqymoHVwJ7Ic6mw8aiZ5fx3En5Ac?=
 =?iso-8859-1?Q?Z8JfvXnwupUqedYikK9g6MLulBsNS0rZUENl2EAH2ikXJbEPVSxIK/vYqN?=
 =?iso-8859-1?Q?XI0lwW3Ouw2TSqMzoTvklP1CR6pP/3rkLrt7KFA0uEIiM+KxY5UFK1RPS6?=
 =?iso-8859-1?Q?MCFybHgPqE4Cslc3n//uC1jC8iDAKPuXw7ylXoKwwmxeRLGAMUX8BYPn6z?=
 =?iso-8859-1?Q?oolAnzzGN3u3Uvaoj6GMtJoUXMw42PDA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gvilBMC2+W+19JXQ7eNwTkTf6R6dfdrcjrP5xUK2VRYf/Yw3jkntsQffiw?=
 =?iso-8859-1?Q?c0C9gNvza4MqCHcTet8kST+mzLf+KI5kZSU3R07sybEfUz8wuS0LX7tFfd?=
 =?iso-8859-1?Q?8JHvP5lf3erStyeqayttNe2aU/DROfyy8+5F6P0HX7l/lL8VUJBLVESlC0?=
 =?iso-8859-1?Q?IdkOP4jYzOJwMLLxYJzzKltMhKKNr/hr+34bsE8E8bgdW1z5tWoSk+v4ka?=
 =?iso-8859-1?Q?50p9LsSNKnDtBymhPulWF183ooEYAwFTsyVI/ox8kg55+TBXRPWUUOzSJP?=
 =?iso-8859-1?Q?/88XYdr89pzozYKQLndveQQ71nZcv0bgBjlYVGrdVJEF6x5N2KQwFLf0fR?=
 =?iso-8859-1?Q?oKg4wYECL7dDM08nSXXyLIriQTgraxTGRZ+/rn6/jfxWYqzfswL3wwh3Lg?=
 =?iso-8859-1?Q?zwg0j0P+oqnnN7sbdi4f8ByFdsBuN01HQvSTKd9BHMSmMmtYlaM4XudaK+?=
 =?iso-8859-1?Q?qpT4Mr+iKCbZgOLbdHcL4GU4Fe+JOfQ8mLYE+RzTLpLltcdBQg6Ar9K2gP?=
 =?iso-8859-1?Q?4i3clO90rg+OEeOk6LWNozxJXTQ1T5t7ISbS/rbBV7+891GnGxl00gqCy3?=
 =?iso-8859-1?Q?UZCFaKKCdrZAVW2DgDsRROMJU41DJFbfrhDX0jGWft1bB5RZG0anCSIScd?=
 =?iso-8859-1?Q?jAM17yWSrZgZ4G25c3DldP+2XCowCphfsJJKzpOGpPScn7B7/EY+An84Kr?=
 =?iso-8859-1?Q?Q0Q2wPHNzRWBBfOkZBYg8hWSlwg1odOcvxwZjTm3+Vt/TGi1VdjI9EgNGg?=
 =?iso-8859-1?Q?rqMprm1Jve+lcA8OwLbNT35n8cvs8Oorg30JtCEYFhZZxzKm0MUKaYEW3a?=
 =?iso-8859-1?Q?f7FAQAr6c384rGvw9/umR9iTFmEqXFUxP8j4B4cV+uYxhDYt40eU3glO8n?=
 =?iso-8859-1?Q?+Lyj5bFMN1iXq8eH9CFQQlwzwFcHNk1lnbh48+CQHq8JpfaLrCopbOHzMW?=
 =?iso-8859-1?Q?ZA+Ss+ylaanZbM5atU5nlbDFoAzqNQnzy/tCeaUzcjEiICN7LeypoBEUrQ?=
 =?iso-8859-1?Q?MimkbqXEV4TFRlj9Fsxrx9LX7YmHONdip1JkXWHxLhS1IpZnXUa8lJI/lz?=
 =?iso-8859-1?Q?W8gihWUl+jK34bw9BfYRGZAWgyGp/VGlMqtHM+bcBO8aNsPCo1SS9+vOj1?=
 =?iso-8859-1?Q?sbZhia1ISwvyWDNMtY5Kw7LcmGqFG8yl31DuNaNLsRKeBKhu+vi5UGQ0sd?=
 =?iso-8859-1?Q?LSymUCPOoBo+HRMz9LVazITkTnEhez2p2tLqdn/DnpuLD6tAq8QJPlDfve?=
 =?iso-8859-1?Q?fdBs9lSy90U2WVTnTmtKLjngtu7LWgRFbvP4aq9xQHy4d3K1EirEKNlb56?=
 =?iso-8859-1?Q?SCEjtv4rNlzdZdB4VsHCJBy9QIHb87E5D6K2I6R9OHQOZDzy+1pIcsUS7k?=
 =?iso-8859-1?Q?W9F4/8iOzP3FtaYJMWANje5SvX/2WdqXbZDtUyd4wXmOJJHK328KqWbQOt?=
 =?iso-8859-1?Q?9X214HcDlzk73IqmlrD51+Vkq5q5rNZuoznReuBIzt7tptwUmRXnmQoDI7?=
 =?iso-8859-1?Q?NAMjeBbwUrqAAXIeBxIhgB/QXx0oF5S3U6N8gNsdzVh+W4XiLHtiuuwHPv?=
 =?iso-8859-1?Q?37kdFccEP60jMzpH+ILhlpQJJ9OwlcxVnXAZDrZDtTifmLbXA4jWRT1uLi?=
 =?iso-8859-1?Q?Lqhplk3JQ/Y7E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af80ee1-6744-4822-3254-08dc6a00ec34
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 17:05:37.4861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6A4Y3Nl9BAWXlH7evPSofsFU6sDM9HVmXoNI13kLydwJDGKBrpSQ+yF+cGioWR0ATLIrcFb8yHMwhLr422ZNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-9.cisco.com

My hardware comes with a DSDT with 32-bit tables, however I would like to a=
dd a=0A=
64-bit table via SSDT.  Although, my SSDT compiles and loads successfully, =
the=0A=
kernel truncates my 64-bit values because it apparently remembers that the =
DSDT=0A=
used 32-bit tables.  Is there a way to have a 64-bit SSDT, to augment a 32-=
bit DSDT?=0A=
=0A=
I don't quite understand the reason for truncating the SSDT values.  The or=
iginal=0A=
code (from 2005!) warns that this is potentially a serious problem in the A=
CPI=0A=
table(s) due to (possibly) buggy ASL compilers.  However, in my case, I wan=
t=0A=
to explicitly have a 64-bit SSDT, and set the ComplianceRevision to 2 speci=
fically=0A=
to support 64-bit integers.  But alas, they are still truncated due to a gl=
obal=0A=
setting of =0A=
=0A=
                acpi_gbl_integer_bit_width =3D 32;=0A=
                acpi_gbl_integer_nybble_width =3D 8;=0A=
                acpi_gbl_integer_byte_width =3D 4;=0A=
=0A=
versus having table specific settings.  Is there a workaround for this issu=
e?=0A=
=0A=
It would be quite painful (both for me, and for customers) to get new firmw=
are=0A=
with a higher ComplianceRevision in the DSDT.  I wonder if there is an acce=
ptable=0A=
alternative.  For example, is truncation really required still (are we stil=
l dealing with=0A=
buggy ASL compilers after 19 more years have elapsed?). Should there be a=
=0A=
kernel command line parameter, or a kernel config option, to disable trunca=
tion?=0A=
Should these acpi_gbl_integer_* variables be table specific, rather than gl=
obal?=0A=
=0A=
I would appreciate any insights or advice you can offer me. Thanks in advan=
ce!=0A=
=0A=
Some additional references:=0A=
=0A=
1. truncation occurs in file drivers/acpi/acpica/exutils.c =0A=
    function acpi_ex_truncate_for32bit_table=0A=
2. initial setting of the globals occurs in file drivers/acpi/utilities/utm=
isc.c =0A=
    function acpi_ut_set_integer_width=0A=
=0A=
=0A=

