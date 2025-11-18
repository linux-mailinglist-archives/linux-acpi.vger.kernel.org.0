Return-Path: <linux-acpi+bounces-19008-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CA91FC68BCE
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 11:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75D9A3547F3
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2A335BB2;
	Tue, 18 Nov 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="CAli2K7w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011059.outbound.protection.outlook.com [40.107.74.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958D3375B9;
	Tue, 18 Nov 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460578; cv=fail; b=sm0zytrg1cf4jk2V1my0alpmmoK4EeBTZmOH/UYPcuLkyFCiq0OlNnWeExEHtfZuO+dc1x+xXJELeNHpM6UjQv8ofx+O6oU0sdNZjEmaFjztTqNqOJvK1cQPQe3APcexQp7nY9AuFWEpKpJDKMSHd5vpBxj3aHSyoZDJa++qyAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460578; c=relaxed/simple;
	bh=nJmPaLfBW/2LJrVUPgg5mc6TUFrWkATxpjkUXcs2xLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qD73QJpsP8mLVobxTRqlrlrXioS+nD94VOUYOAPDjs2uaLJ7TBvmIavmf0spnFcwSkYrWFVwis24Du/kc1wVZLtLVGTduFbridimlFRoW8CQfBpPkru3sEAoM+9Z5NxshtcZkPRDIg2my/XKJhzD+hUBMIoH2uilUW2+p/Evg6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=CAli2K7w; arc=fail smtp.client-ip=40.107.74.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/Q8TvQ0r7lKydvO7+jZjhQtftPpkWLtBCl6H4yfAD27K40xq4j+/FBbjIG7zuwjes7UE1Nsi0KUa21MqIW1qZBhguYls/iwqaRVZsJOQ997EWEqS3oyaiXBJMSRZGmty0x8aFYwlQClOPEkkBUGAAgjdX9zgufy8a6Xadu6eumL56PBL8V4Cz8Co//rZeAxfVZFyFm6jA52MrAUcPzVVO5b9S4F4rYttXSPam5Pypz2RZ/X97KsDEqYV6G3ZI6yLF9T3bYo1BO1Z4NHQDgr2xnzlXoF2j5uHuY7XfGsy3t+8mPL+kEZbXYobCi4ti2rYdh+GdIL9JLF2cyFaK13aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJmPaLfBW/2LJrVUPgg5mc6TUFrWkATxpjkUXcs2xLo=;
 b=bDFQ+i3i837WIk4D57QXQ6p/4T1EixZossOqYBycU8x/W1PpY/e/56vo08D/mZYnrWNeq5mu00N9IxOCSPSM9Owy3qBPmY83ZO/3x7T9HISMAqrGR1EtnJ5KLhc9dbhQuDnTBKknx5of6HLJHZwvAaAOIBlfAwmjSPYMofk4eED6GPZNqFvL3e+5b8Ahgi0cHWZsQ3Xvt+4Qo/b/7nYRsgYBJRDzCnXG94gCrBOqJka2uuN8efoYqlx+7dKQpx72WHXUOv7KyBLm7wb8FkEWztJiSrbUO6XFSpgrv5p6tIhok1obl5r9AJ2mz0e+R0AQ2peJR1khyaKEQcJEq+aeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJmPaLfBW/2LJrVUPgg5mc6TUFrWkATxpjkUXcs2xLo=;
 b=CAli2K7wU00KiWtTHPv22YP7QkBXgPhXXMmZjQtFCR7D/oZ3B4MC26j2WaCZY5epzvd4GVV4LIS58r9E+VaZqUsAmVD/LbkiE0xIfX51yLn0L0OPZOy9bOgrBXlN/1Cphkoe8Pz0WtfguivcnwTQ/GAelBTMFRp89PxCHjXKXqvWInV7AvHWvok5mH03DmnOSGmlCqq6LonTUP4vBaPACsKXB00F04cD7V7sKfXugJ2R6a6R/QftuZB0QjvTH0lixXcZ3DPcW6BN5r/56NABEIQebnb/uWMD3srxeQQst1glhgXFzfwTD/hOCpRLd/8s+Kh8mzG/snZQt1VO1AHbbQ==
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com (2603:1096:604:3f2::7)
 by OSAPR01MB7325.jpnprd01.prod.outlook.com (2603:1096:604:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 10:09:23 +0000
Received: from OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a]) by OSCPR01MB16310.jpnprd01.prod.outlook.com
 ([fe80::5ef2:a4fe:1144:da9a%5]) with mapi id 15.20.9343.008; Tue, 18 Nov 2025
 10:09:23 +0000
From: "Kazuhiro Abe (Fujitsu)" <fj1078ii@fujitsu.com>
To: 'Hanjun Guo' <guohanjun@huawei.com>, Will Deacon <will@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ilkka Koskinen
	<ilkka@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>
Subject: RE: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Topic: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Thread-Index: AQHcPzk5+UU2j3z+uUO7itsPcFLu87TLCuOAgBfAiwCAFXA4AIAAH3ZQ
Date: Tue, 18 Nov 2025 10:09:23 +0000
Message-ID:
 <OSCPR01MB163100DEFA746D8A44FA0A1E3D5D6A@OSCPR01MB16310.jpnprd01.prod.outlook.com>
References: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
 <a93e845a-b084-a680-7158-68363c492b75@huawei.com>
 <aQokdBkjFqw9ZGRt@willie-the-truck>
 <6b14156b-9734-f0e0-5954-57cc76576a37@huawei.com>
In-Reply-To: <6b14156b-9734-f0e0-5954-57cc76576a37@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZGRiNjVjNTgtNDhmNy00ZGExLTgzMDQtZGFmNDg0ZDNi?=
 =?utf-8?B?YzIzO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTExLTE4VDA5OjMwOjU2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?B?ODFlMS00ODU4LWE5ZDgtNzM2ZTI2N2ZkNGM3O01TSVBfTGFiZWxfMWU5MmVm?=
 =?utf-8?B?NzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX1RhZz0xMCwgMCwgMSwg?=
 =?utf-8?Q?1;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB16310:EE_|OSAPR01MB7325:EE_
x-ms-office365-filtering-correlation-id: d0b3855d-30bf-497c-b851-08de268a8c64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0JNY3lwd3NDRTQ2ODRpRnFKMzNYUkRzMzUrZWRLbVJrbDlraC80SVFCRUxa?=
 =?utf-8?B?TGRGZzBwYWNOcjJZMVZwQnpGNXltNVRuemh6RVVPUjdpTHRhSHFXUGh2bHJp?=
 =?utf-8?B?dTBScCtkYUg4RkpLM0d1byszcmt4eVpZcDc5OEtRditJa0hiYWtlQTFMYmZX?=
 =?utf-8?B?c3Y4OC9YMzd0OGs1ZUJFR2I3Yi9SaEJXZlhDaEdmZmk3OEw0Z3RNbGduUnBl?=
 =?utf-8?B?bHNadDBncFJ2bER4c09XK0Fydm5SOWwraVFzUW1qckYyUVZWUk5YOGVvMXpF?=
 =?utf-8?B?R3dRK0pqQUFiaVd4cEhlTTBpUVo3dE5xWHVDdFFKTnl0ajB0NWZJNWpYYmFY?=
 =?utf-8?B?a0Y4OVhlMUxkZHVSOU9NYnBZcU5KM1R0QytoVGg2SDZtTlVMTlQwbXZHWVRk?=
 =?utf-8?B?NzI3Z2RIeHNodndHblNSVEU4ZWFKbG1Xd3VXVk8wMVFNQ1dTbjlRRnFCZmkz?=
 =?utf-8?B?ZVpIL2UxUHpQNFZ3SFl2L3ZlSmY2S2FmRmh5L2hCSTFUN3NCTGtXQkpWNGYw?=
 =?utf-8?B?aDV6NHRrUFJyTFZiUWptdXJDZGJUQnRHNE5xQzhSbVY2QlU3aEtwcEljVTIy?=
 =?utf-8?B?UGdPT3hQanVLVTRtaml2SFdmMTVDRDNGdnBCZnhZLzBxTTRpdktZK1hSM3BC?=
 =?utf-8?B?MXdqWXdaVHNVQlg4Tk45V3BlRnl1Y1RUVUtBaG9meTZJVmw0SGpERzVzc2VZ?=
 =?utf-8?B?ekpFeG5yczBSYkhKWjBnQzcwT2Y0bmlOK3p6ZzE5am10ek9yZGI0Q0Z4aVBW?=
 =?utf-8?B?VVlmaDI4czRjWk0xSk5BeVZ6cWZuWmlOZjN0SThlUit4U1lCcGRyQUtpTG93?=
 =?utf-8?B?K0JMOWV2ek9kWkllbWY4ZFVTbVIyMkRtZmNLRk96YWxkeHUrY3hzOHFHOWIw?=
 =?utf-8?B?SzBEclZla0trU1VzbC9MQjlhTjlRTXVIUWFLNHpHYWpqWTBsamZSWXFJaVd3?=
 =?utf-8?B?ZXZFREFaa2pkK0pqT3pHVkdKKytlV2xvdnAyczNGMjlDNlR6amhJOXNkUElM?=
 =?utf-8?B?d1FtV2wreHZlNThRM0J5YVgzc1k0VGRDOTZzZ2xpbVZ5YkNwRlhxcVVtclha?=
 =?utf-8?B?UzNZSHNsK2x4elVuL0RQR2xXMU12MmF3TGs1WGNLUWo2RFJ1OTVzdGkzQjJ6?=
 =?utf-8?B?VWFkUE1mVUdBRFBGWFRiaDNRb1dZSW9pM0R6TkIwc2ZBSkhKaVVMMEZiSlBD?=
 =?utf-8?B?b1dsYjdGKzdyM3E5bHliWEhpNkJCbmxzb3VLN3BiMVVTMDB5STF1ZGR5cHEw?=
 =?utf-8?B?Qk5BWUp1bnJLWjRheXFsdEJkVUhDamhlazVuZ3F2UDFYa2VIWExBbGErNlVq?=
 =?utf-8?B?TnNyWGhGQWwybThWWk94OTFyMmxXVEk5empIUzVaUWxJOEpCUjVYanlJcDZp?=
 =?utf-8?B?aWlMUWx3MHJhTHB4UDRVUnRKUVVhWWhCTkV5STE2aXFBdk5rYWk5bjBhOXIz?=
 =?utf-8?B?Mkg2QmFKbnRBTW9FSVR6aFgwb2lVNDVpVksrdUUwdGkwQXh5QlZqY3BLWEgv?=
 =?utf-8?B?ZlhROXNKV3U1eitMd0dxZjJQRDdYeUl5UTVLRzVMV0hOVVZ5SGdQcWxLeWZz?=
 =?utf-8?B?VzZ1bUoyRktSdGRGM1cxQktqNW9ZT3BwSVhmZ1BCYUJKaG9OUUpycDNCa2Va?=
 =?utf-8?B?Vk8zTk9acFV2SmRzZ0FEejErYVRYOG1ySUx5RVErc3dRRHEzdXQyMms2RFhl?=
 =?utf-8?B?SCtiQmZ3MUx0WEJVKzdyWXdXeUtRbGRYaUdsZVJQQlRRQ2hDUUREQW9PbUU3?=
 =?utf-8?B?d28yMUwyV1RndENLeDZDdlNCZE9WeEt0ckRRZ05aOWJ3Uk5zMmIxdTkxU0xL?=
 =?utf-8?B?d096S0EwRjQwcmNYbUYrTEFlWnBHQ2EySmpVRzRqNW9ySDVDWStyOVo5QVZH?=
 =?utf-8?B?VlNUSkVlTldiUk9Ed2I5VmNwUmRXdmtlVTFlSS9adnArdjJOa05JbWhYMkt1?=
 =?utf-8?B?ZFZFV0NyMGlFdHBZcTFHekxyOFZRaUNKNGRMdlZKV0x6U1duMkNib1o5VGhn?=
 =?utf-8?B?c0Q5MkZuVVZFMGxLbnNuN05oeFR3cW9OZUdNblBFLzdkYzJMd0Iwdi82Y0gv?=
 =?utf-8?B?dmZFYlRmOUluK2c2NU1sTTdXZlk4L1ZBekNYdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB16310.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cE1KUmRzYzBRY2FMN1JCWmk2VnpPbzV4OTc0NUt5bHV1RnA4VmhucmZvK1BQ?=
 =?utf-8?B?SFo4SndnR1A0QjR3dG5NMytadVpsQkJFakY4RXVuYjNKMW9pTVNubExDN2hu?=
 =?utf-8?B?MUwvclh6NSsvQ1FRS0lYeE14bXQ5aFNPUTdEMUFaTkdpUVFSMm91UCtWcUJl?=
 =?utf-8?B?WFNKelpzN3llcWM5bWtTanpsQWR5RjZHRndGbC9zR2xZNklhZE1qWXVteS94?=
 =?utf-8?B?emdxUGpEaURNaVNyOWQxL2F4cWI2TE1LMFJucHNQaVo5VEZtUFVidHEzZ1Ex?=
 =?utf-8?B?czRkSlA1d2NnWjM5WktOVmMzNTRsbkh3MWZuU2tQdDhUVFZTNHJCai9TTzlu?=
 =?utf-8?B?RzRrVDlodkN2OXo3bHZ5VTBEN3pHbDRlWFgzU2NzMkdZd1dmTUhvTmtvejJu?=
 =?utf-8?B?QmthRVpDSVh5VDE5NjQwZnA5MXFJKzdoQ2V2dTFGZHNpWlR1dG5xcnhLd2I1?=
 =?utf-8?B?UGNSUEc1cEtlVjgyVWFMcHMxUW85TFlTbzJLS2hWOUFsWXEyNFJZdHdLMjVk?=
 =?utf-8?B?M1h6WlZlcUZsM1cwMkJLVlBlWXR4NW5RbnFHd1dpRW9FaVJyM3ZhTWVMNkV1?=
 =?utf-8?B?SzBIMHBxSTMrbnNKRnpZTGtOVDBydTd1OTNmRlo2OVFTangzcEFNaHVrNm9q?=
 =?utf-8?B?NkE4VnZVL2tpUHZaQ0xTdmczdEZrRndaQ1FNWFluYUkrVXdVUEZvajFQWkJ0?=
 =?utf-8?B?VmwrWTVmUDNrUlNwYzVlY3l4YmhzMWMzdFFZNlJERmw2UVAyZ0ppYWtuaDJv?=
 =?utf-8?B?cHAySVVkWkMvYTR0Y2s0amg4WU10STR3NGlSdzg4Q0lSWVJlZ1FvaTdSdXlT?=
 =?utf-8?B?QlByai8zMW1ELzE2cjZuQ0o3cXk0M1RLalU0NFpWVjlxWFowRnJQVk9LYm5z?=
 =?utf-8?B?VDFrdytteW9GbVhwU21SL0E3ZDd1eXNQZXRnWFliUUtCMWJMbkNUZkF2UFBp?=
 =?utf-8?B?dW03bEhxK0ZPY2lQaE5JaWVPYjh5Mm15aVBrUk1NL2dFczlzUSthM2VMYW96?=
 =?utf-8?B?UndmNldGVXFjN0J1VXNvTmVjZEt0NlFSczhYVUZYdFlXeWxnVXVPVEk4UkI1?=
 =?utf-8?B?NzlYU3JkVG16QkpoR1dITFpTaVpXcmllbGNlMWhkUXh2Q3JDNkE4TGhEMS9p?=
 =?utf-8?B?K0lZUEdpd0hlMm9PMFlhZGxWUWxmYWtJdUlueFVhdE9vS0JrOGZHTC9UekpU?=
 =?utf-8?B?SnZlc2pQOHdMMFFpYXh6MUM2WWtCWjQvRHc1UytpSmZ0VCsycm1vOWJ4Z0Jl?=
 =?utf-8?B?MVc3QjdYL2NjK3ZkbnF3UU1yN0FheUx3UkpZWWUzKzEzNTc4MHpsTVFJWnJM?=
 =?utf-8?B?U2V3elNRSjVodmRTR3FHY2NjUjBhUCtQTFVBRnpHMW5UQStQVityQzNJMXBO?=
 =?utf-8?B?ZkRTVTZGazlQN3hUT2J2TmhNUlRLdWpkdGNxLzE5K000SkpZSXNlYzk2S0I4?=
 =?utf-8?B?OVgrNS8yUmdmMkFESWpoeWxxNlJNVFI2RXpYZG93M1ZiZ3ZLS1JteERBU0VE?=
 =?utf-8?B?OTdST0RsTDRlYnZHOGtIZlo0Y3BJcXFyY1U0VTFYempweDk0bmVGSWw5ajNX?=
 =?utf-8?B?VmNQWnk3UEx3VjdnUWtBbWJuanJzNjZLaDhyZktTODgrSy9hSTRkRzE2ZENh?=
 =?utf-8?B?RCt6b0x5Y2xHL0I4a2RCbGJ2MmNmbG1hMUZtTUVab1pxMGQycS9PSmhsREw5?=
 =?utf-8?B?MTUrZ1BiS3FnZjRvd1RVNndkU0hGblMwU1VIWVZpM0dVckpydWw0SmhyTXQ1?=
 =?utf-8?B?V3pmakpXU1RXL1hWazFDZU8xZmtvSjVrbkZCSllNeFg5WmVqbTlMN2VjQURP?=
 =?utf-8?B?b0YwSFgwWnZack94TmRxV1FzVjN6cm9LRUxjVVhrQWI0d0ozS0ZELzZQV2hX?=
 =?utf-8?B?SVg1MzFkMzVmWXRINmZOa3VMS2JpS2dpVVhtODVCZWtpUExLaUdndGNqd204?=
 =?utf-8?B?aEJxb0xSRnpWMitpWEZnNWpSelVObkFzOXc5ZGI3WlBWWUoxRTV2MXI3dEZr?=
 =?utf-8?B?ZWVlZ0pPc0dueTFjejlBKzJVQTNUU3lqdGxkSHFTQ2xLN0VYMlRDMGM0OEFF?=
 =?utf-8?B?ZzB0bGZCUTFzOTJzQUYwUlJtWnhmN1Z0TnB3djBWaEFSaUxtTTlLdEo0cys1?=
 =?utf-8?B?L1BWZWl5akw5RFkvMVhtWmpFVSs2Sk1xbkN5ZnZublFJYWdHUTE5d3JTV2h0?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB16310.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b3855d-30bf-497c-b851-08de268a8c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 10:09:23.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35+lP1D/p40ys6UF8jMfNQ8nIsx4q8WsNiPT16yoBrEubKqMIR7V9lyUyfUvqjdDb7JgLN8qKu8T6dpWaKUpL1Lnb4U0mV+TQfwqmITWxtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7325

SGkgSGFuanVuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQoNCj4gPj4+IEFHREkgaGFz
IHR3byB0eXBlcyBvZiBzaWduYWxpbmcgbW9kZXM6IFNERUkgYW5kIGludGVycnVwdC4NCj4gPj4+
IEN1cnJlbnRseSwgdGhlIEFHREkgZHJpdmVyIG9ubHkgc3VwcG9ydHMgU0RFSS4NCj4gPj4+IFRo
ZXJlZm9yZSwgYWRkIHN1cHBvcnQgZm9yIGludGVycnVwdCBzaWduYWxpbmcgbW9kZSBUaGUgaW50
ZXJydXB0DQo+ID4+PiB2ZWN0b3IgaXMgcmV0cmlldmVkIGZyb20gdGhlIEFHREkgdGFibGUsIGFu
ZCBjYWxsIHBhbmljIGZ1bmN0aW9uDQo+ID4+PiB3aGVuIGFuIGludGVycnVwdCBvY2N1cnMuDQo+
ID4+Pg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IElsa2thIEtvc2tpbmVuIDxpbGtrYUBvcy5hbXBlcmVj
b21wdXRpbmcuY29tPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogS2F6dWhpcm8gQWJlIDxmajEwNzhp
aUBhYS5qcC5mdWppdHN1LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gSGFuanVuLCBJIGhhdmUgYWRk
cmVzc2VkIGFsbCB5b3VyIGNvbW1lbnRzLg0KPiA+Pj4gUGxlYXNlIHJldmlldyB0aGVtLg0KPiA+
Pj4NCj4gPj4+IHYzLT52NA0KPiA+Pj4gICAgLSBBZGQgYSBjb21tZW50IHRvIHRoZSBmbGFncyBt
ZW1iZXIuDQo+ID4+PiAgICAtIEZpeCBhZ2RpX2ludGVycnVwdF9wcm9iZS4NCj4gPj4+ICAgIC0g
Rml4IGFnZGlfaW50ZXJydXB0X3JlbW92ZS4NCj4gPj4+ICAgIC0gQWRkIHNwYWNlIGluIHN0cnVj
dCBpbml0aWFsaXpzYXRpb24uDQo+ID4+PiAgICAtIERlbGV0ZSBjdXJseSBicmFjZXMuDQo+ID4+
DQo+ID4+IExvb2tzIGdvb2QgdG8gbWUsDQo+ID4+DQo+ID4+IEFja2VkLWJ5OiBIYW5qdW4gR3Vv
IDxndW9oYW5qdW5AaHVhd2VpLmNvbT4NCj4gPg0KPiA+IEkgd2Fzbid0IGNjJ2Qgb24gdGhlIG9y
aWdpbmFsIHBhdGNoIGJ1dCBJIGNvdWxkbid0IGZpZ3VyZSBvdXQgd2h5IGl0DQo+ID4gdXNlcyBJ
UlFGX05PX0FVVE9FTiB3aGVuIHJlcXVlc3RpbmcgdGhlIGlycSBnaXZlbiB0aGF0IHRoZSBmaXJz
dCB0aGluZw0KPiA+IGl0IGRvZXMgaXMgZW5hYmxlIGl0Lg0KPiANCj4gU29ycnkgZm9yIHRoZSBs
YXRlIHJlcGx5LCBzZWVtcyB0aGlzIGNvbW1lbnQgd2FzIGFkZHJlc3NlZC4NCj4gDQo+IEJ1dCB3
aGVuIEkgZ28gYmFjayB0byByZWFkIHRoZSBsYXRlc3QgQUdESSBzcGVjIFswXSwgSSBzZWUgdGhl
IHNpZ25hbGluZyBtb2RlDQo+IGNhbiBiZSBTREVJICphbmQqIGludGVycnVwdDoNCj4gDQo+IEZs
YWdzIG5vZGUgc3RydWN0dXJlcyAxIDM2IEJpdHMgWzE6MF06IFNpZ25hbGluZyBtb2RlOg0KPiAN
Cj4gMjogQm90aCBTREVJIGFuZCBJbnRlcnJ1cHQtYmFzZWQgc2lnbmFsaW5nIGlzIHN1cHBvcnRl
ZC4gV2hpbGUgYW4gU0RFSSBldmVudA0KPiBoYW5kbGVyIGlzIHJlZ2lzdGVyZWQsIHRoZSBwbGF0
Zm9ybSBpcyBhbGxvd2VkIHRvIG5vdCBnZW5lcmF0ZSB0aGUgd2lyZWQgaW50ZXJydXB0DQo+IA0K
PiBTbyB3aGljaCBtZWFucyB3ZSBuZWVkIHRvIHN1cHBvcnQgYm90aCBTREVJIGFuZCBpbnRlcnJ1
cHQgd2hlbiB0aGUNCj4gc2lnbmFsaW5nIG1vZGUgaXMgMiwgYnV0IGZvciBub3csIHRoZSBjb2Rl
IGlzDQo+IA0KPiArCWlmIChhZ2RpX3RhYmxlLT5mbGFncyAmIEFDUElfQUdESV9TSUdOQUxJTkdf
TU9ERSkNCj4gKwkJcGRhdGEuZ3NpdiA9IGFnZGlfdGFibGUtPmdzaXY7DQo+ICsJZWxzZQ0KPiAr
CQlwZGF0YS5zZGVpX2V2ZW50ID0gYWdkaV90YWJsZS0+c2RlaV9ldmVudDsNCj4gDQo+IEthenVo
aXJvLCBjb3VsZCB5b3UgdGFrZSBhIGxvb2sgYWdhaW4/DQoNCkkgZG9uJ3QgdGhpbmsgZW5hYmxp
bmcgYm90aCBpbnRlcnJ1cHQgYW5kIFNERUkgbWFrZXMgc2Vuc2UuDQpUaGVyZWZvcmUsIHdlIG5l
ZWQgdG8gY2hvb3NlIG9uZSBidXQgd2UgY2FuJ3Qga25vdyB3aGljaCBvbmUgaXMgcHJlZmVycmVk
IGZvciBlYWNoIHBsYXRmb3JtLg0KT24gdGhlIG90aGVyIGhhbmQsIGJlZm9yZSB0aGlzIHBhdGNo
IHRoZSBjb2RlIGlzOg0KDQogICAgICAgaWYgKGFnZGlfdGFibGUtPmZsYWdzICYgQUNQSV9BR0RJ
X1NJR05BTElOR19NT0RFKSB7DQogICAgICAgICAgICAgICBwcl93YXJuKCJJbnRlcnJ1cHQgc2ln
bmFsaW5nIGlzIG5vdCBzdXBwb3J0ZWQiKTsNCiAgICAgICAgICAgICAgIGdvdG8gZXJyX3B1dF90
YWJsZTsNCiAgICAgICB9DQoNCi4uLmFuZCBTREVJIGlzIHVzZWQgd2hlbiBtb2RlIGlzIDIuIFRo
aXMgYmVoYXZpb3Igd2lsbCBub3QgYmUgY2hhbmdlZCBieSB0aGlzIHBhdGNoLg0KVGhlcmVmb3Jl
LCBJdCBzZWVtcyBmb3IgbWUgdGhpcyBwYXRjaCBpcyByZWFzb25hYmxlIGZvciBub3cuDQpJIHdv
dWxkIGFwcHJlY2lhdGUgeW91ciB0aG91Z2h0cyBvbiB0aGlzLg0KDQpCZXN0IFJlZ2FyZHMsDQpL
YXp1aGlybyBBYmUNCg0KPiANCj4gVGhhbmtzDQo+IEhhbmp1bg0KPiANCj4gWzBdOiBodHRwczov
L2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGVuMDA5My9sYXRlc3QvDQo=

