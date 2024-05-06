Return-Path: <linux-acpi+bounces-5635-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02648BD3B6
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C97284CCD
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34373156F57;
	Mon,  6 May 2024 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="hOU5AVli";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="X6nbeShq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE2157469
	for <linux-acpi@vger.kernel.org>; Mon,  6 May 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015803; cv=fail; b=FIBT9J+lJtmnkh3GhBU64b+7P40S5zLoExQdZHmN6hPZz/cHb+5TCuRwu0pqAEnwPnidmWbalpjCVoYTuOKcZJEK9w/H4BnIPBhzCqhEVs/sU70SKdssquIXhWhJOa9VLwIzqTU73ig3OzhnRdxVDAekcqQIsENXt1v3uSCRb9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015803; c=relaxed/simple;
	bh=ukl6VAumAX/Y0tZn+6YVWTd4kfcA6MZm8+ctqG2rJps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jm9pD97gpAbFQl7zbQVKTECGPSICLszMAeud00PHGC6mwlHwfxV9wRdrOOM0ZdufK6upNpYTtC8hmIdc4qjHBdUVkgK7HPGxoXeZIVpEuBmV3UVzG55vLXBpibZ/xNU80aDkRNzhOz4KiRbXJqrCMlz/PxI0BFBnHZP6mAeOnLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=hOU5AVli; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=X6nbeShq; arc=fail smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1084; q=dns/txt; s=iport;
  t=1715015801; x=1716225401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zojhWFDSg4U3N5OnTidH7gc2efZWJKj5CoPVjyDp18E=;
  b=hOU5AVliuQy8H0eRpuAVYuW96M9UdC/lwV0QNaBax50j9n7L5ctxWzzX
   akPsvyQw7NaB5PkYpq+BofTzkYd5Ogjo8rjJZCr4p29u9JQbhpjZCZmWl
   a5bd4+2J263vbqSOPqZD+aliiLIjNX1bQF+ENaDc9LjbAuEurbbAvr40j
   0=;
X-CSE-ConnectionGUID: OcDCREr3QSegH/+NF3ApGQ==
X-CSE-MsgGUID: nJtb5DYyQOantsJIE0UCiA==
X-IPAS-Result: =?us-ascii?q?A0BlAAC5DjlmmJRdJa1aHQEBAQEJARIBBQUBQCWBGQUBC?=
 =?us-ascii?q?wGBcVJ6gQkSSIghA4UtiG+fLwNWDwEBAQ0BAUQEAQGFBgKILQImNwYOAQICA?=
 =?us-ascii?q?gEBAQEDAgMBAQEBAQEBAQYBAQUBAQECAQcFFAEBAQEBAQEBHhkFDhAnhXQNh?=
 =?us-ascii?q?loCAQMSLgEBNwEPAgEIDgcxMSUCBA4FCBMHgl6CMQMxAwGnKQGBQAKKKHiBN?=
 =?us-ascii?q?IEBggwBAQYEBd12CYFIAYgtAYo8JxuBSUSBFUKCaD6CH0ICgWAChBOCL5olj?=
 =?us-ascii?q?UhUfRwDWSERAVUTFws+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZIBYJBCMDC?=
 =?us-ascii?q?AQDRAMgbxEDBBoECwd1gXyBNQQTR4E4iXoMgzEpgU4pgQ2DE0tshAmBeA5ig?=
 =?us-ascii?q?1yDXR1AAwttPTUUGwUEHwGBGAW7OpBPjFKTR4E8CoQToWIXqjSYYqhdAgQCB?=
 =?us-ascii?q?AUCDwEBBoF7JIFbcBWDIlIZD44gGYNhnTl4OwIHCwEBAwmKaAEB?=
IronPort-PHdr: A9a23:5563GBHxyYOOqHfohd7kap1GfugY04WdBeZdwpMjj7QLdbys4NG/e
 kfe/v5qylTOWNaT5/FFjr/Ourv7ESwb4JmHuWwfapEESRIfiMsXkgBhSM6IAEH2NrjrOgQxH
 d9JUxlu+HToeVNNFpPGbkbJ6ma38SZUHxz+MQRvIeGgEIfWlNmv/+uz4JbUJQ5PgWn1bbZ7N
 h7jtQzKrYFWmd54J6Q8wQeBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:ownlPq9epK0UdtC7vYqNDrUDgn6TJUtcMsCJ2f8bNWPcYEJGY0x3y
 TBJCmmObKzfMWf1Kdpxa97loUJU7JDXn9UwTFNprSxEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4utyyHjEAX9gWIsbzpKs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0JjMDVOFnNbI9nbLfFurgNNAV2guErRNr46bAUkWn
 RAZACoGYhbGjOWszffiEK9nh98oK4/gO4Z3VnNIlG6CS615B8GYBfyWtbe03x9o7ixKNfzXY
 9EEcRJkbQ/LZFtEPVJ/5JcWxr7x2yCgKmEDwL6TjawV/2KO4D1g6Z/kNsbOWP2nHfh+n2/N8
 woq+EyiX0lFb4bAodafyVqoh+nSjWbyU5oTPKO3++Qsg1CJwGEXThoMWjOGTeKRkEWyXZdUL
 FYZv3N066Mz70esCNL6WnVUvUJooDY7UPZ7KcAgszi2x6X0pEW/KDMtVhF4PYlOWNANeRQm0
 VqAntXMDDNpsaGIRX/1yltyhW7jUcTyBTFbDRLoXTc4D8/fTJbfZy8jo/55G6Kzy9byAzy1m
 mrMpykljLJVhskOv0lawbwlq2z9znQqZldpjukyYo5DxlgiDGJCT9f0gWU3Fd4acO6koqCp5
 RDoYfS24uEUFo2qnyeQWugLF7zBz6/aaWGN3QY2QMJ6q2TFF5ufkWZ4vW8WyKBBb5ZsRNMVS
 BC7Vf55vcYMbCXwMcebnaroUJl6pUQfKTgVfquJNoUVOMcZmP6v9yB1bknYxHH2jEUpiuk+P
 5zdGftA/l5EYZmLOAGeHr9HuZdyn3hW7TqKGfjTkU/9uZLAPyH9dFvwGAbUBgzPxPna8Fy9H
 hc2H5bi9iizp8WlPHWJoN9IcQxSRZX5bLivw/Fqmie4ClMOMEkqCuTaxvUqfIkNokifvr2gE
 q2VMqOA9GfCuA==
IronPort-HdrOrdr: A9a23:KZZj36MwIQeDqMBcT73255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UcssREb9expOMG7MArhHO1OkPks1NCZLUjbUQqTXc9fBO7Zsl/d8kLFh5NgPM
 tbAs9D4ZjLfCZHZKXBkUmF+rQbsaW6GcmT7I+0oQYJPGVXguNbnnhE422gYzVLrXx9dOAE/e
 2nl7F6TlSbCBIqR/X+LEMoG8LEoNrGno/nZxkpOz4LgTPlsRqYrJTBP1y9xBkxbxNjqI1OzY
 HCqWPEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwiy6zDb4RGYGqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg6jAz8HXvoGXoxEcL4PaJAA7SOfAxw76xQSGpsnbIe+sMiJ
 6j6ljp8Ka/yymwxxgVqeK4DS2C3XDE0kbK2dRj/UC3F7FuK4O4aeckjR9o+FBqJlOm1Ggqfd
 Meef309bJYd0iXYGveuXQqyNuwXm4rFhPDWUQavNeJugIm0UyR4nFoj/D3pE1wvq4VWt1B/a
 DJI65onLZBQosfar98Hv4IRY+yBnbWSRzBPWqOKRC/fZt3dE7lutry+vE49euqcJsHwN87n4
 nASkpRsSo3d1j1AcOD0ZVX+lTGQXm7Xz7q1sZCjqIJ9oHUVf7uK2mOWVoum8yvr7EWBdDaQe
 +6PNZMD/rqPQLVaM50Ns3FKtBvwFUlIbsoU4wAKiazS+rwW/rXitA=
X-Talos-CUID: 9a23:ZjreVmCGG4lXiJz6Ew5s2GUuN9p+S0bQw1eXYGmWUk9xZ4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AhLLFYAx1FTNsJ/KmfjLn2O2MW0qaqKKMFEpQvaQ?=
 =?us-ascii?q?Xgu6NMzBrGRaw1AmcQ6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-12.cisco.com ([173.37.93.148])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 17:15:30 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
	by rcdn-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 446HFUA6018392
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Mon, 6 May 2024 17:15:30 GMT
X-CSE-ConnectionGUID: kNdC7A6YSR6qHVGKFt6mCA==
X-CSE-MsgGUID: V7nQmRMkRfWQ/VhoXuOlXw==
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=balsup@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,259,1708387200"; 
   d="scan'208";a="8614102"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 17:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXgPdNewkthHqvhwucRfeTJIsJ04GgR70ykFnv8bBihjN/10CzWOIIBZpf1s1Nph3WWkWzhpLM7Y8RKyrp03ZeA14MWm7rR3awTwCAKOXcMCiyxXpLddNCIbKmN5aJJ85JFcccf/yhoSL2JVgzaQ8c5oNHKxK7Q9NF+NHF6L17FCr3hoydgeSnmxseBP7SnQn/jhP1hVpitlNv/LZOEk2lx4/WdPw80vz0H2RpoDdGbRbuNiogs92JMqKRHNVGNb+FOCMmyBSj2Z9aAUBi//59CAahwdn07uR4IPDiwdGbT6XmeQSgmrj5On6fCawklLFIdRjEURsZ2Ou8N3i45mcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zojhWFDSg4U3N5OnTidH7gc2efZWJKj5CoPVjyDp18E=;
 b=mjcn9XANq2KOmZpQXHUOxUOEldr/jkaMKgNOEloS5xaeU+RD8iDepEmNiYUOaxsIqFjoSp6t4UEkQLAykxizl/TeEpKL+TU2Kar86eoxgBzK+ADzgj+EsnYQvY+PRNw5Ojj/A8ORQZbAm7SKBkEEi7whUWU/CQnKdZtr3gTmMDuKAUEEQ2rJZTRE5Glakk9hSBuwnrf6uY1B7YcZ81GRw75ND+uKVW2FGlg5Ji+42tXM+Dhp8i7WPznpPhx6k/8NGhY1DUuFtj2jG6wmhgyfu3C2/dnAO187LI1yXUjP5CvN1mMNsxvftE3IOS2+PT0MWXVQoEQo71WsxtunKtzgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zojhWFDSg4U3N5OnTidH7gc2efZWJKj5CoPVjyDp18E=;
 b=X6nbeShqkI6okCquJmbS1dNJ/BenFMtlzEa3ZZiVA3RdBTGsLMYLyE4Rkco6G6oIr3Tv+sRC1QY3MH3ZjooxCe15BVJebaR8+bRQEL79nA3AFh3nBf1gtimBLvZvmuggppqAGED6HXixQa2F4vethONm4qIX+hdDOom3JXUjBIw=
Received: from SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6)
 by PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 17:15:27 +0000
Received: from SJ0PR11MB6624.namprd11.prod.outlook.com
 ([fe80::f40c:b9ed:f7cd:5076]) by SJ0PR11MB6624.namprd11.prod.outlook.com
 ([fe80::f40c:b9ed:f7cd:5076%6]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:15:27 +0000
From: "Billie Alsup (balsup)" <balsup@cisco.com>
To: Armin Wolf <W_Armin@gmx.de>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Len Brown
	<lenb@kernel.org>
Subject: Re: 32-bit versus 64-bit ACPI tables
Thread-Topic: 32-bit versus 64-bit ACPI tables
Thread-Index: AQHam+WU1TjvEkAO70usXG676rn9lrGI2csAgAGcRPM=
Date: Mon, 6 May 2024 17:15:27 +0000
Message-ID:
 <SJ0PR11MB6624A48E0FF0FA4D0D89D773D91C2@SJ0PR11MB6624.namprd11.prod.outlook.com>
References:
 <SJ0PR11MB662464447DF707057BF43F97D9192@SJ0PR11MB6624.namprd11.prod.outlook.com>
 <2cd5a3d5-ed29-48c7-bb70-e660aff5c0d2@gmx.de>
In-Reply-To: <2cd5a3d5-ed29-48c7-bb70-e660aff5c0d2@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6624:EE_|PH8PR11MB6856:EE_
x-ms-office365-filtering-correlation-id: 298c201f-7651-4774-c211-08dc6df0202c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HxT1O3UtKUrXiItdqS0KKYO8RoOStZux5mbbcn5PZCXJTVMHpO3PRQ5jsn?=
 =?iso-8859-1?Q?XQJmYIkbw0b9MyX1etJSPv3VAU+k3d03lh1oG3tnLysk08v+XI8jtsX3u3?=
 =?iso-8859-1?Q?l5R3QjbyJ/QDEu4mSgb4VfnzTfNeNhqfJi2Zn9gdDuPh9TOujDLOgOsr9W?=
 =?iso-8859-1?Q?E/Qn7jeZFxYp3QF0RxsXMDmVOvtzVI8Gxp/JUkTyqRUPvsXaaFCthCGxgI?=
 =?iso-8859-1?Q?vgUrcnXYHxJB499soCJi5QahnOPsD4S6Nu0YfylYxhHB7143POVbu2kzKy?=
 =?iso-8859-1?Q?kVhJvwYEc3NE4B+JNYbzAVaaG2TE8961/tofgwMwDnZuQKArKlGp+R0VEk?=
 =?iso-8859-1?Q?Am2TWRVqnOQ4I54x8bX9pPZnYihsYsN9zwtQ3NfZZ+7fCSjpZsvdPajNgh?=
 =?iso-8859-1?Q?7VC3Cm6WYk6Oa/oJI0PCg/a2hnQRq4kWzHgzKbham6vle+DVsbNfUWGbb+?=
 =?iso-8859-1?Q?PikIMqMlPhRCGiontzJMOKz99QJ49hTd9hu1UxyhyDtK6GQf9WWLwgPw0D?=
 =?iso-8859-1?Q?JAQhVWFkYT+4AZoEZJ9AYdLc8aNMDibUfFNxYy92MRvGsnGRHBgLthHC+J?=
 =?iso-8859-1?Q?VfB7P20HAgQVRJceR9gdtXHoXUc20a2Eh0Fm+Y6Rzlmv9N8MCUCCmtc6C1?=
 =?iso-8859-1?Q?raCWwZnKEFHpIbhPYSRtGo5OH36cG9yyug+7DSgLuqb76zORdD9qtuHKY8?=
 =?iso-8859-1?Q?SYSG4b1csXligzcIdSYgePtgypLJ66DN2/L/7MQlapeL8uDTFMJ/wjmOQR?=
 =?iso-8859-1?Q?cE/6mmFBWe2h6FT0bLFzbuyeJ5zqkble1CwyCJreqKrHhe2NnPsOc/+FvT?=
 =?iso-8859-1?Q?0JfSO6YHT2l8P9ToTQoUSRwP18oyCrCzJzcgvuXQBstYyGG5+QvhU9ZLc9?=
 =?iso-8859-1?Q?QZRiBrho8J5xHtHW7/niSgKZJPGUqJTsTQNEQkGEwn+A0HasiTbFHDQpI8?=
 =?iso-8859-1?Q?99O17yKDlU+50qmSL/w38jSml0HBdWURIjxEI4uxz+jwKYx13+InEUcA4F?=
 =?iso-8859-1?Q?r2ezEdx/szfI20xsKhTKy2WRJY34LRpLA3cO4l8iSoVcVQAA07ojc4FEqB?=
 =?iso-8859-1?Q?mu4sj57P4iMfHsB+0v60Yxlolr1TGICQ1SpNfr2UeQXnyxqDgj8udqZkFI?=
 =?iso-8859-1?Q?HW8Y1MTrcErKpEY/gmlP1OutvZ8Zwk3XIGK+h7yOoBoHAdfDe51zXcubp/?=
 =?iso-8859-1?Q?hwhzOwzyGsXYWGwvkaLe++GrgdRXqOyIsbxSftRR2g9sDUXGdpQhf/5PBJ?=
 =?iso-8859-1?Q?xRBI6Uik/7AClUo8sTVB5uKdaWuRECvQN925GLHs2MHcV91RFl32ZLQs38?=
 =?iso-8859-1?Q?y/RFj6l/MjRg3dLVujyYdbgz+NRjBuuF0+YEA7XjwaTJXrmCjTBLCQsCVl?=
 =?iso-8859-1?Q?Gy+bImKjaGb4HXSEpRU8JL0+kzCAq1Jg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SOcnzC4hMwGusOdqoRS4yMMOTBoArdBDpVeI/Em+pHVfXm7GjOtBTZZQOu?=
 =?iso-8859-1?Q?45R4X2smaZhvVkG6IK0Jm2rplOB/J8sdAmI3U1SQDCNF7C92xhfuTkR+xH?=
 =?iso-8859-1?Q?uOshHg1rbIqz/DlbLBKu/kZNs3+SnIDXjSwvYeJEzqegYM1uz1V0tcFGLb?=
 =?iso-8859-1?Q?ML774ULN7tKLSkF6l412jGQA4f8SozGamxjb1nvARiHicQyUBv8Xz/IdYW?=
 =?iso-8859-1?Q?LuQRuWxZCSVjDw7MRzliJ+TYvmpUHMTMK1zgoo9pm7/XgzMati6zneCz3U?=
 =?iso-8859-1?Q?xBNIsq7HK1KqB+HhO6Q81aw/+2ncWTyAY9VcV+C8d96zZOUNwTjP92hjXt?=
 =?iso-8859-1?Q?gYbDDZZHfmuWbfOuYtiryYWyXLQL4WHx//fo/NCommMTDvT7eOPSbQLNCp?=
 =?iso-8859-1?Q?HRNGFRy7JPVrxuXfTA/Sy/O6hJm97bqyUQTzY2dueDwD6hjG8QuAoGd+yT?=
 =?iso-8859-1?Q?To7WTuTzigirjTYsi9DfQqtOYpBc6iwibhGEoh9xp/RH9ugHN37NzHNLK9?=
 =?iso-8859-1?Q?c+dau29VNdENIeWnklzRRhmtLWtpuZzfb2AR4hUa+6bs8dCNv8FwbLEpEO?=
 =?iso-8859-1?Q?y8tEqmAiF3thmRrJcqi2axCu3iKo2Lb7YIaLvmPJ0yx0sGkPezRLlwgWZ2?=
 =?iso-8859-1?Q?71Fsieg2TJ0HyU2bQwE1YWGOf7fvD+s4kS7lB8eFrZEf0U0BSd7bNkCIRo?=
 =?iso-8859-1?Q?q8r8tNbOvQraRpadU41AhmbEgs0xKzOLYWNjyL2OeWzvLI3S4ziHzuiM5f?=
 =?iso-8859-1?Q?NxMqwMTMcLMgdIadnDRu+f4UgjNDhxvQ+Ax7PGmbQcFU/l/xQhSM62CrXE?=
 =?iso-8859-1?Q?UqPmLvJR1KyorjfEuEzBC3HAP1XFPJlN2uxNjkqpMSoDHrrdJYzxz1MQ0t?=
 =?iso-8859-1?Q?0LxZkap9njGBJSQBrFBaP10+fxwv34kahgqjZopQ7s++cLK5kC3kTyr3P/?=
 =?iso-8859-1?Q?Lbd3vwWZGyBRO93JZiqGjakxE1nWb9ekSdOhkUzrRYCZ18M03Zkfv4qWMb?=
 =?iso-8859-1?Q?2ISTvwmWHekfHEr1+DUdUBWVuC9quiIrlPO757aRhn37WCZrXwDLnUG3Mm?=
 =?iso-8859-1?Q?cu/JMzL9yU7MyZOx246sF/BDm6+WVvXzREaDifu4v7vRzWgBqbmIsa35DM?=
 =?iso-8859-1?Q?ZKfg+wuHHN9kh443XRVZ50C928od2ndajin5e3CcOTK52lMVgfddPQ+NQA?=
 =?iso-8859-1?Q?6KelVbpdPOTg3RlwistWmrAWsFQejvOOOPJBgBo8cEhDR7WntUCDZwzlMQ?=
 =?iso-8859-1?Q?sAY/RDe//rh7LRy2bVdo085r7ObCJ6mtDXk1YhtdoFQcqtle+09BJ8CMyF?=
 =?iso-8859-1?Q?tTNB/6Uutv5nNGbSfOLrd1Dpwx+XO3Di0fDfzwgzJj6Qp1g5uzMaYoce6P?=
 =?iso-8859-1?Q?sdbMmOG4J8QymE1gK62Fdwua/UfD9EXy9pP56N0Dz8ijNVpuSxvd8o4qzY?=
 =?iso-8859-1?Q?pSYvMpzQPAX2Pcp2Ee4DJqblqmZKC2Cov6ZhvsXSumPw966KmZhuxkRml1?=
 =?iso-8859-1?Q?6TWqicKQOHLh1nrzA0j5lLEAwDdd1aPH6rVnL1x9HL358fO4RpZ1u1eKNa?=
 =?iso-8859-1?Q?yAXTV2TcyVcyfdCT+i8zWtNi44n7KGE93X1e+EO5+zVMGgbbLU7XyWAEoT?=
 =?iso-8859-1?Q?Q2PqIgU1ASsqs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 298c201f-7651-4774-c211-08dc6df0202c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 17:15:27.8795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqN2wHeiuYg9UcgInM2ea1hRDmx0GODZE2NaqFqpn8oi/WMuSnbRLxO2m0zp2UpwwkZXugFsjzk42v2ZadjEeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
X-Outbound-Node: rcdn-core-12.cisco.com

=0A=
>From:=A0Armin Wolf <W_Armin@gmx.de>=0A=
>the ACPI specification says that the integer length for _both_ DSDT and SS=
DT tables=0A=
>is controlled by the revision field of the DSDT, so your 32-bit DSDT preve=
nts your=0A=
>SSDT from using 64-bit integers.=0A=
=0A=
I see you are correct.  The ACPI Spec 6.5 explicitly states as much.=0A=
=0A=
>The only solution for this would be to not use 64-bit values inside your S=
SDT, is=0A=
>there a reason why you absolutely need 64-bit integers in your DSDT?=0A=
=0A=
It would be a convenience to encode a 64-bit match value in _ADR (for examp=
le, while=0A=
using acpi_find_child_device).  However, I can certainly use other attribut=
es and walk=0A=
the child nodes myself.  In other cases, where I really want a 64-bit mask,=
 I can resort=0A=
to an array, or distinct named fields.  It just seemed unnecessarily awkwar=
d.  I think=0A=
the real solution, as painful as it may seem, is to get our firmware team t=
o switch to =0A=
ComplianceRevision 2 for the DSDT.=0A=
=0A=
Thanks for your insights!=0A=
=0A=

