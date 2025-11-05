Return-Path: <linux-acpi+bounces-18557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9DCC380FE
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 22:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DE646275D
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC042DF141;
	Wed,  5 Nov 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DO+8g1we"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173792DECAA;
	Wed,  5 Nov 2025 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377584; cv=fail; b=Z9lBjskS1H1yDlhRBVYynwia4d9FinQ/oQADxlXZL+UZUGW4qdw51VDqB0BWJYVGgMM5TCDWU1BrH9rHjjdpFleHl2445DXx0Q0osogUWg0F9PLP8PTFsRDeiN5WQ0LjzEArjTcSnVqs7D0pRLYpxQ54It20u7CMMDbhq/94hgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377584; c=relaxed/simple;
	bh=dakl426/UoMP/1WAr4hltoMftA4Lmu8wjBHyCBhWOOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yhn1GaxnbnZAUARgcYGDd6EoTO5QAE4lpJ/OirSm1b8xdtGcrVBEfPM9GfYLXyrhliAf3qHGssIFsaep3YEd8ltFsgbFpJK3yA87hTdEtcGMatMgkVkDuhXx5Uthci4Kw1cMfbx/cq2lA8UjowC4kb+grRw3IG5MZYUXcWADtIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DO+8g1we; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4moWwMDeq7+VZIKq1P7zp1PsXi50HLtvw3DNJk2kipHwDXbK9n3tgo+cwENSzIyr3/0Mch8Jc5iM4cWDNYso54Ub6yYzpmxx2EHy5/kQusw1C1sHJJDxCov2DQEW26vOQsh8VlKrDOEhwguzZ5FhR04tomMWC2UfJjHJRolQ35PerKFrXKiMEIsG6uWHaShaIaucHFgbo7q9WAq2KjY6Zcd2eY2TXzeWq5ddYJtOw1R/bOZncP4ulteBEoFFoe2zZA2+4mXyw4EyNeDgdTuhejm6wVdOYVG6rdEQ4uIHMetxNlmk+7hnD1jlV9dwhDeCCDxn85Qvfm7+wrMMxXhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZFd/EJVCjrzEjhWYuI8VXtLezj/79/v6q7Z80Z3JG4=;
 b=SkAKe+9RVhk4LO3ZxMoAgfIUiXfPVUrxGIQ3l4hoxxIU6ZMk3jqtOOawNzEWBkRhLX54p1YAz3+qVRw3UgQSOKV5L/psw7CuzlGQk9lz5Yv8KKS8V8hp92UF/cD5N6RVpmnP4x26i9oEeRocbjrpxoirGSl9EuQWJT3VacfmGc4rrBF183BdYZ15qplp568Jkw5hGWYcSPBF0ZiOJTsbXpGOLt1xBc+pzbp6zEUlHjnKpqWr0lNLpoLq8Rjq1ENmoSQWNsU59u0j37WUj3/xUD6hC27vm4OZuO/TNJDUHQeKh+VftEA4erOSt6424pyHmSgbD3kHX0OcSw2s4Nev5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZFd/EJVCjrzEjhWYuI8VXtLezj/79/v6q7Z80Z3JG4=;
 b=DO+8g1wedQrj62OCDS9zUmW7JTAtUQSpPsOZtsF1gT27L47S5gFZwk17jQuI5Zn1rwZlJE7Kbd5J3w5Zu4NGKVrL/cMuxqFiNhs+rKAPQgFvPwTzFFMKnCl4S9qiNjZ5JElHxYp9jzWA6mzz9wWnB5dP6MZNgVf5WZRQ6vtF4OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 21:19:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 21:19:33 +0000
Date: Wed, 5 Nov 2025 16:19:24 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Tony Luck <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, Andi Kleen <andi.kleen@intel.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: Improve ghes_notify_nmi() status check
Message-ID: <20251105211924.GA1264471@yaz-khff2.amd.com>
References: <20251103230547.8715-1-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103230547.8715-1-tony.luck@intel.com>
X-ClientProxiedBy: BN9PR03CA0421.namprd03.prod.outlook.com
 (2603:10b6:408:113::6) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 672a576b-2bd5-4410-1338-08de1cb10394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+HYMXVUc96f+AMtNPgR8FnJ8dpWGpAsQVMHlaqD9zo8SumrH/VqpMy3tS9Bu?=
 =?us-ascii?Q?/FHF+0wxZvnIoPovoqALMHcQv4mGJVABt7FcNLshZVoMXsU9g8MbrtdM3WU3?=
 =?us-ascii?Q?IMGWyZEHjteU5ZTVr6YzjUeUDVmKzC3e+yKvqvzG01zlQmT4o53uF/jnfCh6?=
 =?us-ascii?Q?CNFHwxhtBC+a9t4inY/jZgGVGInT3LxxucMLdSuIdrc7T6ihK1/VDADDGW8N?=
 =?us-ascii?Q?U5Cap3syyfU7YcNbtQKgpn60Kq1YOnBbctKuEcQE3xWhQzezYjnVMPjtSIuz?=
 =?us-ascii?Q?dc1oDE1qMB+CkHxrMfVVwAyNg7fP+Imge0f0F1PwhcDQ3W3yQTRV2r0F9HQY?=
 =?us-ascii?Q?Qgis37w3ouyNYWesROGUNgIdVG0n//P5jVAoUVALCYXDgBdAaShXbyUV7ufh?=
 =?us-ascii?Q?YpAidkXRdZmQRiBD6zQW3Og5SWZvYrJnKlJYyFzuc99kks89Zp3tgS8peh2L?=
 =?us-ascii?Q?oyrPJZjmhO1UFvjDeMgE1ICCLIcNp43Q//a71ruGHWkm5O0QaX/OMa3X35Sd?=
 =?us-ascii?Q?MAM05D0FeHkQ684D2OHR+cGY9/keZ8Ct5feQW6ErFAidg+2VJ4Booz0Jo5lO?=
 =?us-ascii?Q?0YRwKYn6+7qz4lRsHCv841rCq/w4Wg929/5rNDwLPech/OqW6yLFFXMCDQmH?=
 =?us-ascii?Q?9xMVjm5fV9zQkaB4+6mgDbYmatnhu+TwN9g0qk9NnAQViAxaoZbH52dYhkYO?=
 =?us-ascii?Q?p5DM4otF2CLna3hA5Xv8W5/fILkpHGBF4dUcjzjNVLscHuCTUW6c3gAqKIzr?=
 =?us-ascii?Q?LHftexdTAfWbiQN5kNr4tDF4xobQLHR0nTU0v5U92c1CM2Rj49zqCA5Jdtgi?=
 =?us-ascii?Q?4fEFpEI0Zmya/DF/KNwi2jk9s0f+6zbxMco7v+gjVgF6OLb4jRabgSyNEN4G?=
 =?us-ascii?Q?ii4kA18bLKAVxg5U12+nVip5+7Fz9ZDMEILlPuFETM69AvcDWxJnWvKBqCjl?=
 =?us-ascii?Q?0AvON4EcHeXe/T0H5zOF+Bx5jGzJw9njjzdXzqv4Tj2mhYR3aZew1N6W1t4q?=
 =?us-ascii?Q?wsaBHzx8zNnkJ5CgJUcPkNyeKW/ff2QvANxqvXD4y7o1lPR9rgSCpgeHnRif?=
 =?us-ascii?Q?ICZXoM2JxK7DrbLhEKbZU129vx1YiZ+aOCAw/SuDuUMvz6DQcSW8Tw8nupBD?=
 =?us-ascii?Q?zLBBwC8JSOygU3zB8957ZtnKvRCzOcIkMrufx53RZN6GUd1KHdkLvUVGT40a?=
 =?us-ascii?Q?GmAFtQVNPTFfFpuz6KYUtryycuvFRwW6nwYh2i7QUTn+E+PQVDMtSogVMPcm?=
 =?us-ascii?Q?5z9jqG1gmd0wInXXbkwZA86uwrj7h+8M4n/HAE29Z5nojRma3+X9om8tLV/D?=
 =?us-ascii?Q?YkN1ZjIhldge+FMAES7b2EGJ9gRrji2pemwhSwGb1aXtyMpFhqxYdVvip7zf?=
 =?us-ascii?Q?6DSlYC61WCcCjOYqOqP1+/YCI5hyirzYQx2e9+p5fzJWzaxxG8+v+JecGw/A?=
 =?us-ascii?Q?xaDF07olfhIuR8TvRwYsORSPtjC8/dZSmKedCuRPO2stQKkX7tyZyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sccz8IBLrDnaBoFmlAjAtYA1i6lIcBV/ymfZ3pbnQctJWpR6q379FJNePd6k?=
 =?us-ascii?Q?QVFQlk30KcPipr6Hg6H0FL6Yimo6Bb1CowuuvLYhO8wE1zGV2T4DwpZ0oZPe?=
 =?us-ascii?Q?BIZ6usKCYy9PzqiPYJj04yxZnNOQp2qRN0DJc6nihH+i8fQ8gQrodxglLmWo?=
 =?us-ascii?Q?dH7wCT3C0AJUfT8SSObTQ+i7BW5xbHqVLAiEY4IOXiYTVDBJeCpihs+njLDd?=
 =?us-ascii?Q?ukRLUnwf6ag8FsoDF2ERrPob85UTZAIiQ3oPHDII3sm9egkCUnoX1xxjTqP2?=
 =?us-ascii?Q?8YQrjTTZsK2LwNupZF86pSalEhNPQ+5CzQWplCcbGGammysSAntYS5cjTRhq?=
 =?us-ascii?Q?JabWBdKKY8Fv1I7JaofXlOsA77zkKCCVNRVBmNP1TXDnA/c9Sv+q/fmGnqhR?=
 =?us-ascii?Q?oNiOd6Ub+0iD1SyEZIURotjM97YMpEBeE6p6pK7wHHbeht7ZbbWyL6WRgVxu?=
 =?us-ascii?Q?4NDzkSse8VuHnrn1FyxATfRMkCdlVMAZ/EExkASGyS9r+3Y5OqQSIoEXDOGG?=
 =?us-ascii?Q?M+fsmmlToLZj9IXvMGxn47QVaqIQ9hgm/rN66q0yv/wouZbknz1Go9rVy8lS?=
 =?us-ascii?Q?nMoX4jStcHfpCD3fKrz//Xj6WNRrmH6It6EdPILpspEcmapgMgM3twiiTr3x?=
 =?us-ascii?Q?of5bn4Rv1LalQeSEICaZHR3nmianWj6CENhnekxt7yEZ5vCsep+Wpkf3vJg1?=
 =?us-ascii?Q?LcCybURHUWzoLq8TDsRn8r6ySwneNDjAiOKG6A8aaJ6P2jN/5fpN+I41skiQ?=
 =?us-ascii?Q?vNTFYxFKF5/YLwd60fSgtTWH3MYL5dBnrP+cM96HrTDmHBd6bRvcPAUy9McB?=
 =?us-ascii?Q?XXF/qnX1WafDYQSsNJrW7EH3xrZjuN3GZbmtvguPGXmmWJHcUb3yBL51Jac3?=
 =?us-ascii?Q?skBF/SKZRV4hZjD+PcRkuvs3IND2rRm8fnEWUdHUP0rsisMbT9jzs9oyLP2c?=
 =?us-ascii?Q?DwAgNnTg0jw8kNf7pag7Q2xlwH0KYPeHv1rznLuIcv2pSOHdBDAn6OeNNrt9?=
 =?us-ascii?Q?wTm3JRz/xzv84w8FTZ7Z/iYaVGwh4kjOhdLMaSl8P/uWqE7EVU37bKZPWIIr?=
 =?us-ascii?Q?/8g+ci7DRJ4/PQsHNNsLc3ubxFcyCfqcx5KqVhRkGPXDq5LMYKE47KswrSeo?=
 =?us-ascii?Q?gkmb/YoaTVH7uMCyQihdl04gXQbFpvqzFkTGrC6AUmWJApcRJaZqpHDbDEaS?=
 =?us-ascii?Q?TatM6dLjn51qO3WZGL+DPTGWhP8HfP2vP3k8uYfRkrTBaT7EHYQu9tyBVR6N?=
 =?us-ascii?Q?5qmrMrwsLAI7TWtH3E0n0/onkz/5j9kKk56ftoApLiHSR4x8cgvW7V7JmPkV?=
 =?us-ascii?Q?00cXHNqHfxgwpSP/n5ZyEn8J1AIuQJx3y4egCXZb1A4rG19iySzwBcSlUfb3?=
 =?us-ascii?Q?n003kdp9jfMqksIOaOKI2LYAPt33909CVcZWuSpS8YOc96ywRTULEwST7IAS?=
 =?us-ascii?Q?5cwQ29KPqn1uZCdfNZH6140KTfvPRrGx3wEk/RvbgkGLL5nH+AQkb8Fo+CWH?=
 =?us-ascii?Q?iyB+r6qmm2fVKieeo8j5IOqrAgqj0QikY1L+J2nBWYI0s3c6OSloH3CYPvwX?=
 =?us-ascii?Q?oAb84qpTMr5DMoOIiYyu8h6DjsD11L2SnEh6ixCr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672a576b-2bd5-4410-1338-08de1cb10394
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 21:19:33.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoAD4Wreo5hQkYIAmbaSdG58ic4vt1OtZEFD7hIKSrn/jLKRYjhiSu9lt1/stq9oK8dB5aeirc/inwhfQE96zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

On Mon, Nov 03, 2025 at 03:05:47PM -0800, Tony Luck wrote:
> ghes_notify_nmi() is called for every NMI and must check whether the NMI was
> generated because an error was signalled by platform firmware.
> 
> This check is very expensive as for each registered GHES NMI source it reads
> from the acpi generic address attached to this error source to get the physical
> address of the acpi_hest_generic_status block.  It then checks the "block_status"
> to see if an error was logged.
> 
> The ACPI/APEI code must create virtual mappings for each of those physical
> addresses, and tear them down afterwards. On an Icelake system this takes around
> 15,000 TSC cycles. Enough to disturb efforts to profile system performance.
> 
> If that were not bad enough, there are some atomic accesses in the code path
> that will cause cache line bounces between CPUs. A problem that gets worse as
> the core count increases.
> 
> But BIOS changes neither the acpi generic address nor the physical address of
> the acpi_hest_generic_status block. So this walk can be done once when the NMI is
> registered to save the virtual address (unmapping if the NMI is ever unregistered).
> The "block_status" can be checked directly in the NMI handler. This can be done
> without any atomic accesses.
> 
> Resulting time to check that there is not an error record is around 900 cycles.
> 
> Reported-by: Andi Kleen <andi.kleen@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> N.B. I only talked to an Intel BIOS expert about this. GHES code is shared by
> other architectures, so it would be wise to get confirmation on whether this
> assumption applies to all, or is Intel (or X86) specific.

I think that is how the ACPI spec describes it.
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html?highlight=hest#error-source-discovery

The HEST and other tables are fixed at init time. There's an ACPI notify
event for if/when a device method needs to be re-evaluted, but I don't
think anything in APEI expects that.

Thanks,
Yazen

