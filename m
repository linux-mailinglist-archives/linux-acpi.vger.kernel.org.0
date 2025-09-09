Return-Path: <linux-acpi+bounces-16519-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42742B4A316
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 09:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEA917AE18B
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168303074A0;
	Tue,  9 Sep 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="J0YrU4xp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F8306B27;
	Tue,  9 Sep 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401896; cv=fail; b=Kqm+kUKDDMvTcLIzC0ksmZ3i0keTmMB1FdAv+juCkeQ/Vqr2e2eMAA+rA/WPJPcHxSXmBHgErza7ys7K1ITl6p2b9WBVOfAen1iXtYWXFhidwM8UojI1uMnDl0Tv3iCsdLCYgG1Pr7HoW+Ou7KCIrcaPjmXVMC04D8r+72Qw/SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401896; c=relaxed/simple;
	bh=VnRWKZB4nWVhplzeduPQohVEBYR+s5GGKSNO3STjFxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ThbW0jIMTQrEM/gQKNxc+Nr8iBhcy+fLgLWMyIEPVHFpq7h5iG6A2pEACdTFqvmkE/ykNlDl8GjhSDBhgq5oU9u3IJgf5X0W+3LItwHCc3p255j3oH5IdBBseFyHKn0SRG/PRHDxLgHbEpfE3c6yc3MKOlBuNPDdc4y4ZyZIjhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=J0YrU4xp; arc=fail smtp.client-ip=68.232.159.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1757401895; x=1788937895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VnRWKZB4nWVhplzeduPQohVEBYR+s5GGKSNO3STjFxo=;
  b=J0YrU4xpGDDC1lja46wkn8UKb1ausV4fsL/paYhc+01HuiydZ/rtpPO9
   unHaYDuLlG/H9HK9z3A24uL9SeZ7yfjQoToAY0T7ke/wFlSTjh6JzzoEX
   7Ynhk6tX0mp/OUOcWEUVLFRuDrB3qsUe7vJmU/MjL24WZPhXNdc7LSYDa
   XEQ+jcDnsO2Sr2tDWW19BG38n07MxsCfDJbU1mE1uEJLBcFkFNiUbUdHo
   YxsvkkgEvGVXBmfn8zs1uZqxiNCBYAGYnRDhE9vzjFwJGPWLNrlu+d5gV
   UL8VSIEJgMug+0KuJYf3Iic7HXwCuCC962qMkrCf6orVjXCzAF/ES8Bpc
   w==;
X-CSE-ConnectionGUID: s9wJZM0YT3OfdRAfPp88CQ==
X-CSE-MsgGUID: DLQZKM7IQmK+o1rkw/eByA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="167181463"
X-IronPort-AV: E=Sophos;i="6.18,250,1751209200"; 
   d="scan'208";a="167181463"
Received: from mail-japaneastazon11010039.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.39])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 16:11:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itqhJrxb6WBObxyEPEn1yzAXbcgW8RbjfjnUITArr38j9eAzo1qrxV/nOFALJgAj4khyX55+RXHQadKbZpBRCmcGOv7POkdF4ya3elpmKV6KNn+x65uS6tcmydMCP+PBOyecnMMEWMt0Q20BjV6XEkNim7RENgZB4FP5yyq9nqHLzFReFFV/A2PZtCvQTYL0NXA6aPMytcgFwGUvCf4ILsH5Ikw2ugU0MUBialVBV+khzZlqhGFiHS7bEURoTdQmMSD6xmzwQ9XozofObxvacCQ7dwJbPyleWaL272pnA7xzeH6yq7+2vxothlxxuysD85TT8Tm9uRgMB2Y+ShyFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMd8bROjMBl3uMa2OgTo5ry5klNsmd/F9muUioeSeqE=;
 b=o8+mW1YvviYb3WaivpafRt8RkbyVdmOsqKCDUOEJFVPuj/2wa1/mTM9j6kAGHeZiAix4WonOfjt7Nhn31/A6NW+5jJFKFczIPPQRbOZol4io4i5/3tt6Meem1h4rSY4F+6N8c05FQzsuzIkM0yir3jHBOjccd0y2r0nZgnrqM4SQJ0rIvqNggUVmi8GVo/eR/kb4fy26+8rOOPQ77W8+wwBqTL+JDDgSk7rhBD0g1nq34RZ6m8WEBW/leJa5/EcmXE1GqR2akkFsFbCDi++wdAqub8jAcbNhBtNUf+tyo+T4hrRQivXd8WpkPuusM76eoamKIenl6bW2LE6c4Q9QWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYYPR01MB16351.jpnprd01.prod.outlook.com (2603:1096:405:14c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 07:11:16 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 07:11:16 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, Rohit Mathew
	<rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich
	<dakr@kernel.org>
Subject: RE: [PATCH 11/33] arm_mpam: Add support for memory controller MSC on
 DT platforms
Thread-Topic: [PATCH 11/33] arm_mpam: Add support for memory controller MSC on
 DT platforms
Thread-Index: AQHcE3pimFXExtWe8U69MBHCxiUW4rSKiUww
Date: Tue, 9 Sep 2025 07:11:15 +0000
Message-ID:
 <OSZPR01MB8798A7AA3C2D11E2D38381BA8B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-46-james.morse@arm.com>
In-Reply-To: <20250822153048.2287-46-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a496b5f5-504a-40ba-9e48-447698e9779e;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-09-09T07:05:29Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYYPR01MB16351:EE_
x-ms-office365-filtering-correlation-id: 83fb3978-877d-436b-ff7c-08ddef701124
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?QVRaZEV0ZnoxOEMxa3ZwNjdCalQ5Nm5HWmNhVmRtSWhnc1h5d2pjV3Fj?=
 =?iso-2022-jp?B?Qk9xY1NTdlFDMkpOYk5FVUQzY2FUQjZ2YjhJZ3ZCKzBHbURjcHhKb0NV?=
 =?iso-2022-jp?B?ZC9RZWRwL1loakdnWm05UWk3OGl3OU5rZkIxZnAzK3gwQkxKcFVvN1pJ?=
 =?iso-2022-jp?B?WHdBQXlVQmhrazB5eEhrM1NUMzFaQnIyNUlLVnR6UUM0cW13T25UTzYw?=
 =?iso-2022-jp?B?WS8yL1VjYVBhVXNJZ0s3R1h6Q0NaMG16cCtsblAvc2dFUjJHNnhWMWFk?=
 =?iso-2022-jp?B?Q1BTWDc0OGhFWlZYNloxU2JSWHBaaG5RbGd4UUwwUytSTkNOOTdCbkdY?=
 =?iso-2022-jp?B?K1BXMVc1emdTdkxMR3BsUjRBNFdYUTY0NGs5NCtDbk9RNWZmTlZWbHlF?=
 =?iso-2022-jp?B?d0oyZVdXRm9rbm9iUWthMnlTYm95NXVWbE9iZE5XSjF6R254bDJMeHhp?=
 =?iso-2022-jp?B?UkFINDVoSXFsMXJESXp3WUo4NUJKSzFuekpRT2pmK0ZvR05Ubno1dTR5?=
 =?iso-2022-jp?B?NHZtOXM4QW41Y0V1WjNranAwTlAybm5FaDRKVUVUMGo4aUhFMUZmMVA3?=
 =?iso-2022-jp?B?SXBMVFVRKzBIUm9nbWx4RFc4dDNoTmoyTk1zYTlaZkhZTFY2U20vb082?=
 =?iso-2022-jp?B?amlGbUR4d2liN0hOemc1Z3hlOFRXTUhxaHF3dXRxNW9wWGZzYW5JbWg5?=
 =?iso-2022-jp?B?bkdiMUUvRnlCQmZnWmxRdy9ocWRBU3lwYWhPcmk0VFZsdzBkU3VIUkRH?=
 =?iso-2022-jp?B?QkVESVc0akdzbTdkcGJDV2JBMDNxOTJVV2xkMWlkRmJqb2xjSWthby9v?=
 =?iso-2022-jp?B?dngwVnVPblRmUmJ6QTBNUUpTeEZ4eG9MQnhvS3Nsd0o3TVZpKzUvTXNL?=
 =?iso-2022-jp?B?TVhTeWhxZyt0R3JQZ2ZrS3puU0ozNWc0eEVPVFpJdTM5WTNnNFhPNC9h?=
 =?iso-2022-jp?B?bWs4bGRxRCtKWlNBUDB1ZllmU0Z3dll1ellVSzFCVnYySHgzWjA4ODIr?=
 =?iso-2022-jp?B?alFWRm9Hc3A4SlRnTjRZaTk4TkNhYUhNTklUTVNTamJad2RHTElVTHU0?=
 =?iso-2022-jp?B?RjVXaFVVbEZsVXU3SWQrQVBWbitCekFRNTFkQXFsKzBPVHAvMTZkL1Fk?=
 =?iso-2022-jp?B?T1AwSW91N0QxQ3Z0aEJFU0RtZDRjSjNFMlhUVytUcjllUUw4a1lKUnpZ?=
 =?iso-2022-jp?B?SEE4cTBXd3BrNStDL2FPeGRUelZMQmdURzRIMWVSRUd0bGtDaGlwR1Ro?=
 =?iso-2022-jp?B?a0ZlSisybjk0QXlZYk14dTU3OWNLVVVsNDEyRG5KdFU0QlFMaGJQSmdk?=
 =?iso-2022-jp?B?M3FRRktxSFBweUdhZXg5S2dzNVgvdVNuR0F4VHdCWDVicFI5SURBVUQ4?=
 =?iso-2022-jp?B?aDFUSnFiUUE2UkYyaThidmw3N1FtRkpFZEhNdHJEZVBwaThMN3ppRXdG?=
 =?iso-2022-jp?B?M1EzYkR0dVI5aHk3cGlaODdtN2hDVDIxQzdZdHZ4Mng5WXNnZ2YwOGh5?=
 =?iso-2022-jp?B?MGIySWNmYk8yT21rRlBNSndNVDYvTGR4Z2ZIUkpOZE1MRUZZeTJmaUlz?=
 =?iso-2022-jp?B?YVNlRlZWRjQ5SWFxU281ZCsxOVNreVdJUEpocmRGWkVWbUl5b3NDSG9z?=
 =?iso-2022-jp?B?N0RadVRJelJoeVFUdmhySXhWU1RuV1BjNVJvcE5iMHVYMDRMOC9GRXVq?=
 =?iso-2022-jp?B?OFBieCt5OWN4SkIvRkZ1Y3JKTk9yRVdaNkhXSVdTY250YnFiM2FQRXRv?=
 =?iso-2022-jp?B?RTd6eVhISWU1ZStKZnJaZWZnY3BDQmFsekVjaDdrTE1mSXpWMUhrZlYx?=
 =?iso-2022-jp?B?OWZBLzcvSmh4ZzBNTVozY0ttNW1BNHR0Vm4wN25qaW1lSzFETE4wcUtp?=
 =?iso-2022-jp?B?Um8vdUd3UGVLUDkvVVRkL2V2Rmd2ODRUQmdOMFk4UlpkNnlwaUx6YUY0?=
 =?iso-2022-jp?B?WGxCTko3SGZmMnVpZk1oTW1KcTJKa1U5RUNlb2dzVjJadXFHWWlWRFBJ?=
 =?iso-2022-jp?B?aG5IbWlJUnczYWJLSFl3MlJKSzkvbFhlRzB1Z2lxeFFKNFVlaDhrVlhK?=
 =?iso-2022-jp?B?b1QvbHc4a1l1eEozZHdTL2RFcnFEb2RwL2dUV0pPSjgvaDVZU0gyZmJi?=
 =?iso-2022-jp?B?UGwxUmVrQVprQnROUGpnNENrUjZ6Yi9saWVIY2tuQVhRbzFhRHRiNnV3?=
 =?iso-2022-jp?B?U3FocFIydkJ0eGd0bUZVWW53QS82WUVS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?M2VXZytKWTJOc09KcU1BbHpDUUVLRlgrUzlGYWUzNmlFMnFRbVVmYlZW?=
 =?iso-2022-jp?B?THB2aFRwMXVWa05iRGV1N1VpaVlkNEFmZFJqQnN1dGFzRy9ZNmd6K01a?=
 =?iso-2022-jp?B?cFA2cTkrTGFFdmJjN2JVdzJ5WWgwUHhaOXVQYzducVg1SUFrZzhrbzRK?=
 =?iso-2022-jp?B?Y0pYUjg1UExDL05xQ1dFWVk2NG55eXV3OHVWOEdOaHhOK0x5ZGVDNndx?=
 =?iso-2022-jp?B?bHJOZmIwcExmWi80YlNhN1Z0SGdzWHdVZkNPdU9ESDRRVm5jZllGdWQ3?=
 =?iso-2022-jp?B?RjNwVExWMkZVeUs4UXAwcTR2SzNDZXRMYTdEclY5TklMQlJCZ2pESGh4?=
 =?iso-2022-jp?B?WVpxcUxXdWZxbXhCTlZVZWFTUUt4UzEyMUJPck5sS3M5MzVZVXl6T3BQ?=
 =?iso-2022-jp?B?K0VJWWtrcW9VcWlwOW9PQnBab0ZpWTJZeUEwUldzdDFyUmdYUVBZanBR?=
 =?iso-2022-jp?B?Rzc5RUY1WXV5T0lpeGZNQVlRNTdQUDRqcjl6U01wZHFTRTcxdHZvVnJS?=
 =?iso-2022-jp?B?SUxmUXNJd2IvcmNUWEFIRlVBWXlpU3JOSEtvVldiQ1YzWnpmU1JBUSt3?=
 =?iso-2022-jp?B?eGtGVGNtcG40ZXZzNUhEQTR5Qm9NYmxOczhyU2lPdnhYRnRYT3A1aktm?=
 =?iso-2022-jp?B?Z1JtOXgyVFFGSUFkSWJ5eExLeUNxUDRlZngyS3I4dnROd1FqbmN6V2Zn?=
 =?iso-2022-jp?B?TFRiQVdtdERLWnNpMVYzOUNoQkdOQ21xNzY5RVUrQW5aT2dmbWhaQ0Uz?=
 =?iso-2022-jp?B?OURYdjhQQnZwVTE1ejc1WVlURFUrL2ZCZEhxOGdUVDdNbUM0YmhSOG8w?=
 =?iso-2022-jp?B?bTFGZWx0cG1aaWd1N25MbklhSEZoNHY3VlNoYThPOUlSUEl6OXVNVGRO?=
 =?iso-2022-jp?B?L1ZOVkt6SWsvUTVsOGpkT2ZKdk9sY1VjQmllSWFCY0RKTWd0Q3NoTE1u?=
 =?iso-2022-jp?B?TmpsZFVpU1JJN2t6SzQ0dHRZalp1UjBCTGYrYlFNUXIzWlAxZG41M2JF?=
 =?iso-2022-jp?B?U0M3WnVjejNRUUJCbWk1aGlhTGx4dXFsdm1ZNkxsNWlXVzVLRWN5UG9C?=
 =?iso-2022-jp?B?WWo2b2U2SWJkVnNtdGg3bCt4bTJyQUNQNXVTWm5kZEllOGpRZW1sdlE5?=
 =?iso-2022-jp?B?MFg3UVdTTEUxb3Z1aWRwUThPVGdPUFVKdkpBMTI0Smw0dTFPY1htMmR5?=
 =?iso-2022-jp?B?K3BFUllldDI4ZjJzeFRyYW9KSlVaT1ZWNU94ZHYwWk9DYlVXQnZsSjhP?=
 =?iso-2022-jp?B?cUUxRWVCWXIzbUU1a1pCQm40SkdtTkZQKzZsY2h2MUJ5UjlsMTZVVzRY?=
 =?iso-2022-jp?B?cll4MEFteUUxRGtXakM2S1o5aTFXR3NyU3d4MStzSkRkb1JaK3JHYmI5?=
 =?iso-2022-jp?B?SmNOU2k1dnIzaWpqWnVtMDhRWEczSFdpRG83QkJQbXYwMjdSSE5FM3Ux?=
 =?iso-2022-jp?B?T2hGQU12TFlXdXJ4Z0FYK0o2VU5odHp1VVRCMW56Vyt1ajIyMElISloz?=
 =?iso-2022-jp?B?Y1RWT1VJSWttVE5HaW5ZWTN4Y2pOZklrY3ZqRkV6R3VBSTg0d0VJcjMr?=
 =?iso-2022-jp?B?U3ZxRXhUVDBUNERYeS9nWURnTnhadjVUZXJWQWVwVFBDMG5zays1WGxZ?=
 =?iso-2022-jp?B?VHJ4d0ZmNHR0emlRSlBMTUtFVEttVWZMUEh0YS9tNE1TL3llQjBtanNj?=
 =?iso-2022-jp?B?d3JQVi9NY0oxMlVUaEpHN3JsT1JTYUJjY29jb210MUFPZytqL3NtNmhF?=
 =?iso-2022-jp?B?ODgySkJaNmczZXg0THlpRnpLNmhPNkgyY29Sam5BK0kweTFMYS9HeWs3?=
 =?iso-2022-jp?B?aGJ5UFZaY3daeDNtcGc4alZBK2VLdTZTZmVvK3lXUHBONUJ3a0N0VlR0?=
 =?iso-2022-jp?B?WjBEZnFDMHc4K1d5aVBJRWFGazNoL1pGK2x2SDh4ZlU5YXNXK1R3RVdr?=
 =?iso-2022-jp?B?OU4yTG5velh1S011L1RYOCtndE5FejJBR3lUL29FUzdHaUpYcVpEak1V?=
 =?iso-2022-jp?B?QnlrVWFwSEJGUmZVdURHSjNjYlBrZ0R2cXh6Q2ZUMlY2YnVmQ3RERDdC?=
 =?iso-2022-jp?B?eldQZFZGSWJIQ08rMytoQlYxNDZ3Nk04Z1Q1Wm80aVZCTnpXUjhjcXR2?=
 =?iso-2022-jp?B?bUZuY3VGc1hMUzZsREEyOHJ1NTI5NmladnE5MDQ3bkxKUDZpc1BXd3I5?=
 =?iso-2022-jp?B?cjVVUDdjUmswZGdzaDhxUXVlVlBBWVM4dkpKQjAvb042bGxMZW56bDBN?=
 =?iso-2022-jp?B?R1BwbmdFdEVpZTdZMzY3dHNCSnFuK0RhZ2U2UXNwRXZzekN1anhFRnYy?=
 =?iso-2022-jp?B?SUcxdFFzL0dpTDhpb3FIMlI0SWR1UkVydWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aSZ1Lcpma48L7BNNgordYY5p23WuSct/5GikTNSavq2gp2kErVIhEEXsc2DkHaWf+2QBhFDMBBzujkJfJh7G4dV4H6FdeCqPjJycYxxsDr74HE0oa+t/qVhNYukA+Fgde9IWtjvyYmVGgLzAzuMQLuVvsakDiHXOKTpiEVgfTwozLhIMF86ynIwGB0Jx/tk6cSm9EQH0keGdPiZi9TBMvZ4dpuh+xQIwxwTIcIUfL/w25yncXuaiFsrWJ3gVYMVUhXAEn5+SNc13g4ZjScFYtiqqt/9SUNipRmYv4Yf1vQG+dx+/LjUEiJpoNf7go8N0tWZ0JL12E97OBnY0av4yfQUMo1Ajima2H+lDBep9HlAGqXKmCe9Jn9zjkCm7tuCc6tN2dNtCuwAJlbaxHYwKcMzV8rNKiL0Q7rpvd97OQcJQW5qFivu4z2ziyvockeWOt49j47rFHuvl5rTs52ilrHtlmjkXaeeiP9gTExpkSyJW9kWScYmWFCMFMLLz16FU3ONdrdN7Gmpfl2SnuCvJcqwuVd+zulXSqyNHgU8blCEjIxjS0YdgjjQNkx+38s+vziq8RzhCmXfukEUsX0qcETZ/lMXX4GZKOf9ZvxN4r5mkAN3aaCn5OYcZ7Wrup56B
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fb3978-877d-436b-ff7c-08ddef701124
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 07:11:15.9147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdNOnGbsXRtwIpj/JYuoREmqAfpkZ6g6W/N4zqCDE/2UOqd4nnUIEWEzQ0XbgJ/wuCW2pDFQGJP3/f1aNsi8eRsyF6AcpWCfNvIv94WsaIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16351

Hello James,

> From: Shanker Donthineni <sdonthineni@nvidia.com>
>=20
> The device-tree binding has two examples for MSC associated with memory
> controllers. Add the support to discover the component_id from the device=
-tree
> and create 'memory' RIS.
>=20
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com> [ morse: split
> out of a bigger patch, added affinity piece ]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/resctrl/mpam_devices.c | 67
> ++++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_device=
s.c
> index a0d9a699a6e7..71a1fb1a9c75 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -62,41 +62,63 @@ static int mpam_dt_parse_resource(struct mpam_msc
> *msc, struct device_node *np,
>  				  u32 ris_idx)
>  {
>  	int err =3D 0;
> -	u32 level =3D 0;
> -	unsigned long cache_id;
> -	struct device_node *cache;
> +	u32 class_id =3D 0, component_id =3D 0;
> +	struct device_node *cache =3D NULL, *memory =3D NULL;
> +	enum mpam_class_types type =3D MPAM_CLASS_UNKNOWN;
>=20
>  	do {
> +		/* What kind of MSC is this? */
>  		if (of_device_is_compatible(np, "arm,mpam-cache")) {
>  			cache =3D of_parse_phandle(np, "arm,mpam-device",
> 0);
>  			if (!cache) {
>  				pr_err("Failed to read phandle\n");
>  				break;
>  			}
> +			type =3D MPAM_CLASS_CACHE;
>  		} else if (of_device_is_compatible(np->parent, "cache")) {
>  			cache =3D of_node_get(np->parent);
> +			type =3D MPAM_CLASS_CACHE;
> +		} else if (of_device_is_compatible(np, "arm,mpam-memory"))
> {
> +			memory =3D of_parse_phandle(np, "arm,mpam-device",
> 0);
> +			if (!memory) {
> +				pr_err("Failed to read phandle\n");
> +				break;
> +			}
> +			type =3D MPAM_CLASS_MEMORY;
> +		} else if (of_device_is_compatible(np,
> "arm,mpam-memory-controller-msc")) {
> +			memory =3D of_node_get(np->parent);
> +			type =3D MPAM_CLASS_MEMORY;
>  		} else {
> -			/* For now, only caches are supported */
> -			cache =3D NULL;
> +			/*
> +			 * For now, only caches and memory controllers are
> +			 * supported.
> +			 */
>  			break;
>  		}
There is no need "{}" here.

Best regards,
Shaopeng TAN

> -		err =3D of_property_read_u32(cache, "cache-level", &level);
> -		if (err) {
> -			pr_err("Failed to read cache-level\n");
> -			break;
> -		}
> -
> -		cache_id =3D cache_of_calculate_id(cache);
> -		if (cache_id =3D=3D ~0UL) {
> -			err =3D -ENOENT;
> -			break;
> +		/* Determine the class and component ids, based on type. */
> +		if (type =3D=3D MPAM_CLASS_CACHE) {
> +			err =3D of_property_read_u32(cache, "cache-level",
> &class_id);
> +			if (err) {
> +				pr_err("Failed to read cache-level\n");
> +				break;
> +			}
> +			component_id =3D cache_of_calculate_id(cache);
> +			if (component_id =3D=3D ~0UL) {
> +				err =3D -ENOENT;
> +				break;
> +			}
> +		} else if (type =3D=3D MPAM_CLASS_MEMORY) {
> +			err =3D of_node_to_nid(np);
> +			component_id =3D (err =3D=3D NUMA_NO_NODE) ? 0 : err;
> +			class_id =3D 255;
>  		}
>=20
> -		err =3D mpam_ris_create(msc, ris_idx, MPAM_CLASS_CACHE,
> level,
> -				      cache_id);
> +		err =3D mpam_ris_create(msc, ris_idx, type, class_id,
> +				      component_id);
>  	} while (0);
>  	of_node_put(cache);
> +	of_node_put(memory);
>=20
>  	return err;
>  }
> @@ -157,9 +179,14 @@ static int update_msc_accessibility(struct mpam_msc
> *msc)
>  		cpumask_copy(&msc->accessibility, cpu_possible_mask);
>  		err =3D 0;
>  	} else {
> -		err =3D -EINVAL;
> -		pr_err("Cannot determine accessibility of MSC: %s\n",
> -		       dev_name(&msc->pdev->dev));
> +		if (of_device_is_compatible(parent, "memory")) {
> +			cpumask_copy(&msc->accessibility,
> cpu_possible_mask);
> +			err =3D 0;
> +		} else {
> +			err =3D -EINVAL;
> +			pr_err("Cannot determine accessibility of
> MSC: %s\n",
> +			       dev_name(&msc->pdev->dev));
> +		}
>  	}
>  	of_node_put(parent);
>=20
> --
> 2.20.1


