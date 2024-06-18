Return-Path: <linux-acpi+bounces-6507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B990DE60
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 23:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AA41C20297
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86D1891C5;
	Tue, 18 Jun 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S9nt7Vk4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91961891D6;
	Tue, 18 Jun 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745873; cv=fail; b=Dgt0aQxqo/h/dXwu5slwe6saTjBJiWftYXUZcERQM3gOEmizl+zFQBY0yrw1dhYNB0Y+9AhWCxbGkRbaJ2SwuM5Cf10FnhrQFITqqH/V3UPrBZI3Bb++h9D8bHNZnT+ejgbtnVdvXZOCjl1TRGO2nmiZreyzodyUJkcpzwdFKds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745873; c=relaxed/simple;
	bh=RSozKsRjJDE5/jrFBT882i86z1r49RYLZOdMJyFFKxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dnXptl5xWJlDnUfC555Tb5G1fv2JYcFpgtQH6eIJexrmC8dYmEPgIXc4aTGamglwcoXwKVWJxtZm4TFSBbz4bp8tZwBmaoRgPmct0a9jzmaQNdCFdtxRhi/pmQFZDz/s4hXcGaHuXY7CGdyAwgXEIsRaUf/TYxNjBhx2626qylA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S9nt7Vk4; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irRy33ev4SbYA4gw4XFatm77FVGiFZL1QUzQw/u+a+PlcWpzNyhzo4Mg3ACHFCDU61Lkh6ORtQEw1ypzkHlshdZ/Cv8UUm++TAsZ2s61VgNSPSlPnI1ZUsqFb6Y0U9Arc30j345i2y7oAwBr0hccdS39pXws3R0fVS4Fzmw89JBVj19PkbCiEz/DB+YUN0Lm2H9MXSGZbzISopL+Tf6gPiR18mz8HRXLz6TBso2STYiPC2X+5/Hk2iPaKp9UtVgf81GCjC3E3Sw6eNQryafoel+ISUWFRmA59CuBOnb5GIvgfo3CrqFonDMXS/vuPkUr0FU7VVlyljvyOUSJHU+82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVABbhqxLPTDK41jrX46bqy8bk7BOq7WcD/hUjVS2qg=;
 b=iREh5LO6s1/LX1xAtzuOT1xW5nMccuNP+uqu8tMfzKdnVTpzrXdOB9OcWiyCZBwMztwhM92GqFLnSr/rNWhdvXX4ZLcF7vPwQXBRvpxM9PVJ5QZBHYPLFJz9iJcj3f0emm/dtCYk/Iwq2G3qyG3O2pucHsOnrJJWz3QjY4z6YhkL7g+c3UxMfIVj7QGjiwcFe5LZZ3UD6VNy80YBP8q44pyWOngRNurUjMM/cJ4hj/n+rJPPya+KBwjvbq86kPZQcGhFC545QU7mlGX5reSCUG5uF0REjZckdSjYkkDPhxB8flT/PFNOrRyiOSwqysYtH4WwzTgLlwoYu90tVzAXoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVABbhqxLPTDK41jrX46bqy8bk7BOq7WcD/hUjVS2qg=;
 b=S9nt7Vk4mjWJOLlJz53JhPIKXDRC1CQfvKcCf6NFFqyoDS4H6PIYH1K/i/I15ziXMXMPLqsi8uKYdSInU3zElNt9PE0aYCNluunofthf951rV4BWH/lSh4Xq7/DckpYCN31ZlkHhdGaM+4XqsYcbmn7AFZWz8iXZEkkB8WacFLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 21:24:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:24:25 +0000
Message-ID: <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com>
Date: Tue, 18 Jun 2024 16:24:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RFC] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
 Perry.Yuan@amd.com
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com> <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com> <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com> <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com> <ZnHtPbszYT8afOOk@kf-XE>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZnHtPbszYT8afOOk@kf-XE>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0086.namprd12.prod.outlook.com
 (2603:10b6:802:21::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: bbac4154-3feb-4a6d-998e-08dc8fdd078f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzNyRjdCZTJoSXpTaEZGUVhwWTFRdXh1eXdSUDJPV2dwWmVDYnE2L1NjT2xh?=
 =?utf-8?B?N3FDTHAvN3k1RElVT3VDL3d3Z3RqdlB1N2FXMkJVZDN0ZDd0WElLa09EaWUw?=
 =?utf-8?B?bGRzZVptMkxPQ3VpYWxOWFJ2T0lLQlUrR0c0RlZ6R0lSUTB0Qm1OaTlpODRq?=
 =?utf-8?B?RWo4NXBXR0NCd2lYMEp2SlNBc2xHN05aRXF4bE1TcEVaT0h1TU5oR1hEcFJ1?=
 =?utf-8?B?VGcwQm80M2U5bGFOVWwxUWdxY2Y2dkh0Z2d6KzI2VndkOEdIN2tmVDlIeUVY?=
 =?utf-8?B?UEdHWkJSNVhhYmFERmc4VjY1ZUhHZU1XMStTdE9uQTVyWmNjUUJuSXNzbHJt?=
 =?utf-8?B?eXNMaDJLV3dKQklkUVorSFNhQXdTZGdaaWR5TW1scEovMERPMHcrcVdKR3VM?=
 =?utf-8?B?YmxoQnhVd0NwWWVYV2VPQk1Obm1SbHgxVFVVZFBjQzdnU3Z3OGovVDRiNXp4?=
 =?utf-8?B?amE3US96RzlCSHhPSkJGdUJuWklNR2pqc3dXSHJOeVhPbDJ5ZzJOdnhBQUps?=
 =?utf-8?B?d0hqTEJSU2VGMFVFdHFMWkhCc204UTVJa0pMMUpGR1Bxc2xxVVdETk5pbEx3?=
 =?utf-8?B?d2xldXJib2VmWUNUQVVManZRSjZVN0U3eThZYXloZE5tYUFCQnRDNHpIS3BR?=
 =?utf-8?B?c2tNRHBjUFBzWVdGam5HWEI0M0ZJL0NWNmpaQU9nSXp4aHNWMFFYbzFhVzQ4?=
 =?utf-8?B?bndQSU05dEJUVU5wN0xXckdiUGVpY1Z1Z3pjV0V2RUJuNHN6R2E1ZkE1QzAw?=
 =?utf-8?B?NkRCeXN2RjRGZEI4c1hpby9YK1czQU5OMlQxMEFrQ1hxc0cxQm1Pcjc1aTRK?=
 =?utf-8?B?NFRMZmpRc2hRcTI4OEd5RHZDMGNWNDFsa2pLZ3UyV1JKMkNaY0wwWWw2OVJ4?=
 =?utf-8?B?MHRHY05BbUdLNjRtblAyRWsxOEwwUHNUMjlNNnB1MURUMU1qSWtkRnR5UlZq?=
 =?utf-8?B?cHZMWG9MQWVLQmpDa2p6NVRsdEZmWVZoSmd2SWtFd1JzUzBXSlJSeVV5MVMw?=
 =?utf-8?B?U3N0ckdSejFmeWt3M1JSLzhGaFVTa2xMd2hhcWFjbnlZZEczQktMWW5OYjND?=
 =?utf-8?B?Y2FuZytOZmpPS29Oc1lWRHdMbFQvbnJaWVAxdVQwdEo4amlFKzNBRHllOUJF?=
 =?utf-8?B?MElZZlNudXFyMUJrSDZwL3dQd3VGTlo4Z1JtNkp3UG1ORzB6c0JNUElzUFdN?=
 =?utf-8?B?NEM1a09yOWgyQWpKcWw2SGRYYXdYM2hKNEo2eXFWV0RHL0VQejgweFl4REth?=
 =?utf-8?B?dXlWMi9BT09sRmVGMTF4dllSZkt5SXBFZ0dqUXdrQkx6MVN5S29sVzFoVGNT?=
 =?utf-8?B?QnloVFpIbFZWTysybXhBVnRWb0pSenRPb2N5RDJvaTNhQ253UnZvNDlrUE1i?=
 =?utf-8?B?V09QRmoxWjJBZlNSRFFjOVRnWmtpVy94RTNBUTZaM1l2N1YvOVpRTUkwMEM0?=
 =?utf-8?B?OFBydWljcmRuUXRXdk40WmNibTVrS2NjdlR3TVpsZ3BEd0hXeE5lL2NtYUNY?=
 =?utf-8?B?Q0YvdEZQTXpDTWluOGdieWFndCs2M2lKQzFhQ2tnQWtCWWI1RHhMamxBMFpW?=
 =?utf-8?B?bkF4ajdIcU4ydkVmQml6MmZkN2ZrbWZlMmEwQ1VLNFFwTGJxb0RLSTNxcEVU?=
 =?utf-8?B?NTZuaVJoZEI5ZjVITEc3N3EyUldleDc2OTYvYUdMSFFhajUyMUJmU3l6NnVu?=
 =?utf-8?B?dzdYSXNHUUdOdm80UE1TbXFpOG9seUM4ZitnUlpZR3d1Uk9OUVdRaGJqYU81?=
 =?utf-8?Q?0iHqPm3PT9x9DbIi2CoPAW0K5g2viRSsCEIQs8E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW1zVG1vVXZyMXNlY3ZOelVFb0ZyeHVZS0ZwRjU5VWhXd2VYUVlsenFUR1Fs?=
 =?utf-8?B?SmFsN1ZodS9FUVB0N0Zma2VQQ2ZrZUpoRERMNFhERU9pL1hlaEpoMGpPV1pW?=
 =?utf-8?B?WmR4SUQ4VEppb0tya3NCczdzbStCT3FyV1Bkc1Z0TWxrZkRhcjVMcGMreFlX?=
 =?utf-8?B?UTdyMkc4bmZ1MFVOSlRPQ2xuUk1uUXgwQ0lUcnhjTlVxaXJBRnJYSWx2dldW?=
 =?utf-8?B?VmtzY0RGQ1ZFSDJiSGdmdzBnZjhBRDkrMHVnRDhKdmlpT1RCQjhWOFNpUWZR?=
 =?utf-8?B?Ti8ramJQanR1eXdkdjRwdkJVSXlvUG9YaEFRWVB1SzN6a3lONTF6RkZ0YlNL?=
 =?utf-8?B?S2tDWXp5UEs1Q1REM3gzYllYSVZIRWo3Q2lQTDh6RnVJRXAvTWFkcU5aR21j?=
 =?utf-8?B?VWlJL1g0SEtOQ0R3UWdJT2NCQm94YzcxWU1HV28ybjFCMXVlVTFva0NTZmxR?=
 =?utf-8?B?ODNRbFQ5MVpZeFI1SVYyRlkxaXpwWlNkTjVKaXV3dEVCblJPZ3JoVWpEcFBi?=
 =?utf-8?B?NjNmTWozR3NNMHBpQmw1c2NmdklCRURMYlZTTEluWHhKR0dFZllLQkZQcStH?=
 =?utf-8?B?QVhrOFhjSXpyQzQxRE1lMGNLcGd3NVd2cWhGOTBUSXNETnVkRWE0MVFUdkQr?=
 =?utf-8?B?YXJBVXo5bTlFM09KQ093N0J5alQ3bVBCWUlYVFo1OVFhNXhVN2RBVnNwSUlY?=
 =?utf-8?B?cGp2Rno3ME11RmFDNW9SR1lMWHl3VUd5UDVLVWZHYWJwZkhUb0RjRS9hR0pW?=
 =?utf-8?B?aHVKbVhEU3dIUFA1blhaNmp5bzY4NVIxUkVEajlKZzFlekxYSVdLOWJsdVJt?=
 =?utf-8?B?Mk5oWXB4REYyTE9RakM1OEZURXFHVXAxQXRGamNoT0FaYU1sR0pXbjFwcGFB?=
 =?utf-8?B?czJFaGFIbmlwaHRTUlJiVkQ4UC9WWUJnVFVDUVYzMHEwMXJWbTF2SzNyWU16?=
 =?utf-8?B?Ulk4TnRyalVDRE5BbE5WQmJLQ1U4VW1Gazg5b1dpeWZJSXlxZkJUamNXdTdm?=
 =?utf-8?B?VE1UN2lFVHliTDJ4a0p0MjdUa0pOMjVrdDArZHZVb2FIQkRHQVh0K2Fub1FB?=
 =?utf-8?B?Wi9jbGRPZXBBakRmSnhUbTBiZ0hKN0RRMVY2azlDN2lvTVNKanJpUnM1d013?=
 =?utf-8?B?ZndUU3J6MWxHdmZmdlBjSnA3MFVWQi90NHExN1Y3aUFSUlhWakdpUnQwWXJ4?=
 =?utf-8?B?c1M0aytCR2svRkhxZTVVWFRPSE1qZE5LQnNEVmRabEFLcVJVYVFXWDZTWmUw?=
 =?utf-8?B?Um53dFVBVzk4NFNSUVhsVzN2dnJlQUlIUUpkMElVRUVBaDlQRVJFakdNVFRz?=
 =?utf-8?B?K3kya2lBL3draGNNY1BBNzJjbUhHOTZwcVNFU1Q5YUV3cUt6MzdaQWtzMExQ?=
 =?utf-8?B?VjMyTFc5VTBYek9DWGdaS3VLSHJTQnVJUnhPcEV6NFlKL2kwdmJaR0M3NEQ4?=
 =?utf-8?B?MlFTVVY3MUU2QmMxcVRWZjRxNWxPK3kzd2lwRXJSUDlseVhSdURsSzFoNjBD?=
 =?utf-8?B?MDh4dmlGYkxNSXV0UlhvTFlkUGpuOVdYbzdLTi9IWVFWK0FCc2ZpVlVJY0dr?=
 =?utf-8?B?cS9Qbm9nV202ekM5aDQzUExXRWVvVFBNSXUyODdINmQ4Ym1lbWx6Vjh4Q0Mz?=
 =?utf-8?B?OXlGczl1dUlNZEZ2WkVJK002RitZbmpzZ0djS0JWNEJoMGdsamsxbEo5eHd0?=
 =?utf-8?B?bzF2UTF1eEE0UUdML1ZrTzdtMUZHVnNHblIzUW1tQnRjNkVqdHQ1VGVpZzF4?=
 =?utf-8?B?S3Q0WEV5Z2IweE9QdG5Cc2xYTWxpS0x2dVordzEwRmZMSHkyRUZxMjRQRW1m?=
 =?utf-8?B?Z2FWK1FsMVBiSmhNd3NZRzVDcENZVE9PNVRiL010UVBINTNPSFlNbytJd2VU?=
 =?utf-8?B?NUhjRnZGeDF2UGEzKzAya05rWnQxY1YxTmoxaUNaTkhGVndjR1BOTThQZVcy?=
 =?utf-8?B?ZHZiRTArMklRemNKb1RIZjdCT3NxS0N6TzZ5eFErQlpkcW8xWlVhU24ycW0v?=
 =?utf-8?B?K3VjOXprNWFGVjY4TE1RcTRMeFAxWlBhR01UR1dOWHNWb0o2MDVJUnhGRUdC?=
 =?utf-8?B?OER4L1Q5Uy9tYk53c3FPNjVOS0RWa0FmOW9VdlF4RElkbDhMWFc1dkVBb21m?=
 =?utf-8?Q?uHtln8n5/Apsi2dsqfHO0Kuiw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbac4154-3feb-4a6d-998e-08dc8fdd078f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:24:25.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NB43T6scb0lv48PZ96G7ypVKC/70oKMkcM3UDqqQcmwfyTjdbO7vDOCazddj+Gkcwv6BHHYiFdq1DUHuem2/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152

On 6/18/2024 15:25, Aaron Rainbolt wrote:
> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> 
> The _OSC is supposed to contain a bit indicating whether the hardware
> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> be considered absent. This results in severe single-core performance
> issues with the EEVDF scheduler on heterogenous-core Intel processors.
> 
> To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
> which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
> enabled. This allows CPPC to be properly detected even if not "enabled" by
> _OSC, allowing users with problematic hardware to obtain decent single-core
> performance.
> 
> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
> 
> ---
> 
> V1 -> V2: Rewrite to work in cpc_supported_by_cpu.
> 
> RFC: I have not yet tested this patch to ensure it functions properly,
>   nor have I attempted to compile it against mainline. My system takes
>   a couple of hours or so to build a kernel, and I'd like to submit this
>   for feedback now and test once it's sent.

Thanks, this matches what I suggested, hopefully it works when you test it.

One comment below though.

> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b600df82669d..af2d8973ba3a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2063,6 +2063,12 @@
>   			could change it dynamically, usually by
>   			/sys/module/printk/parameters/ignore_loglevel.
>   
> +	ignore_osc_cppc_bit
> +			Assume CPPC is present and ignore the CPPC v2 bit from
> +			the ACPI _OSC method. This is useful for working
> +			around buggy firmware where CPPC is supported, but
> +			_OSC incorrectly reports it as being absent.
> +
>   	ignore_rlimit_data
>   			Ignore RLIMIT_DATA setting for data mappings,
>   			print warning at first misuse.  Can be changed via
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index ff8f25faca3d..7346a25e68ce 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -11,6 +11,14 @@
>   
>   /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
>   
> +static bool ignore_osc_cppc_bit;
> +static int __init parse_ignore_osc_cppc_bit(char *arg)
> +{
> +	ignore_osc_cppc_bit = true;
> +	return 0;
> +}
> +early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
> +
>   bool cpc_supported_by_cpu(void)
>   {
>   	switch (boot_cpu_data.x86_vendor) {
> @@ -24,6 +32,10 @@ bool cpc_supported_by_cpu(void)
>   			return true;
>   		return boot_cpu_has(X86_FEATURE_CPPC);
>   	}
> +
> +	if (ignore_osc_cppc_bit) {
> +		return true;
> +	}

I think you should move this check before the switch statement.
The reason is that such a workaround could then apply to any CPU
vendors and models that are AMD or Hygon too.

>   	return false;
>   }
>   


