Return-Path: <linux-acpi+bounces-6503-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1938890DC7C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 21:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21C528196E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9E16C845;
	Tue, 18 Jun 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S1Fwr+KV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784116D4DF;
	Tue, 18 Jun 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739192; cv=fail; b=moqbFvTa0rMmWNHQ1bJHv1ZKFKiAWrmI2c30JrPf2mHjLLTSk9EWTbXNYWJre7UFPsTX3T8T95vJyVjV0NYGIW9lR8cPl9l7I0mUaH3y92PZ7qoiKuHUtRzY/IWlAkxKhfWFY6IuX/nsNfgElconeDYI68oPKPn8ZEXddYwsAbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739192; c=relaxed/simple;
	bh=XU+5gPBb0VH3S9Y8LanjFUFqnObpYg+cxMT5NwfrxLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p5DNfh11kED7gKeV06TvVKtOaHLeqQQWXhOWkYm95oO1PNSCTrED5EPxhyXoBxDIJpdsiO0d7LSxFo36qLh1ahEK87ev0uJe+8wwfTH1R2ZnO6Hum3sh4SC4bxszO1Nl3tNEOaAA1VvpmMqHwK3Dy4AJPjBj+Tyn4jnnypKJ5hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S1Fwr+KV; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftdFDeKVSF9pvZVOcEDvSDVOkdFt4oPAQ8e/ugkBKb/y2UtahzA3PPtjR5nM4NHbHw+cvOxVG/+LbY4MpazscDY+JfAVuCMv73IgxrCZeBdp2nPN8g154CNKSDnMfOtwxLccGKTiEwF/RtNhE90xIDmolUhh1vZQjrk8oUDoFIzjKA1jgEvUrf/O8F7OVaKMLCXzhRhIfXYqQMmFJkLUQamxrudO9Mdf9vY6z1CIqODQ92+B4T/wCRENYgTzsH46PVTcFa07jaOB3DZTBKg+HUJmqGVKvSTzz+43I4P2+Bd/CXwTqevPQcYp76yXXBq1I8RVOhZSoQw45gYvaM1K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/ouggsgy/uedmLYKVmOCMUKrY8gJGCi5MWA88eP5Us=;
 b=UkSa9tD6mORhlACPkOK50gthf8y7vA7hHcgPTzz/i3hdTwtljs0mV9WSORm9WAtVZteVfln0vyeQ6FfvDWZ/ohzHTmOO+oAvfRqwNs6egu8EXrie8HDpWemWh6Rqxn1THuJ45SPqfXwym6tFXRIhhJjgWkkHeSWkE+LmmlJuRmAFvhpuETwPZMjwAi1O00q70k2R5fwiy88HvMiQ1TKTcvH/TyuddgNitRM3wBDg4rfXXUNFBG4MR1M3HtIVjExc58x13/U6y1mM10Ch6C2In7diR+z+KArFdmCY9ZDKIUHhmAIyiY6B/Rsf7c1q1Xc1Pp6w2YeGQurnxjy7EtTjbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/ouggsgy/uedmLYKVmOCMUKrY8gJGCi5MWA88eP5Us=;
 b=S1Fwr+KVH1Vodxxxkx6/sDdgBh3s/9MllmNycz/jjd3gSR0mmxcfLtifQ1tKOyuDrirES+fyXeTyUn/A0927VU3JSQKRk/rCI6+GB0NJla0qyJVwDmv4UTH5JzPw1XuPjILfGDXp4vGzteNMb97zcmiowIVW1V76LLD/JCqqrs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:33:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:33:08 +0000
Message-ID: <50fcefb1-e910-435d-be0d-d0f45071d179@amd.com>
Date: Tue, 18 Jun 2024 14:33:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: Only evaluate the Intel _OSC and _PDC on platforms
 with HWP
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:ACPI" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 CL Lin <clin41@lenovo.com>
References: <20240614193241.7341-1-mario.limonciello@amd.com>
 <CAJZ5v0gMcR1wkOMkd5kHp8BZKdZd-HE9DrxByP9puCK-OUfGPA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gMcR1wkOMkd5kHp8BZKdZd-HE9DrxByP9puCK-OUfGPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:806:f3::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: e8617eaa-f8b0-468f-4100-08dc8fcd7bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTUxNzM5eDlNN1BSOHhibjM4c1lsbEdIa1pKRS90OXR2SllhYWVzWkxjeFFC?=
 =?utf-8?B?b1RrQ2VWWkZHeW9nNSs5bE5oYW5EbzJSY3l2UmNBTTFtU2V4ZzBIQ3pHTzRx?=
 =?utf-8?B?OHd5QkFIU1p0MlZvKzhZVHliU1J0bFJXUWNhRUl3d29BaGQwcnA3bzNaU3pG?=
 =?utf-8?B?QlZUQy9va2VkVzMwVVExMWdOSDJ5bE5CdWg4VUZ6U3poM1VnUEduMjhpazFk?=
 =?utf-8?B?SVpTTFlKS1J3TWloemhObFFvb3JFOTc0UjVwQVA1STdxVzhjdFMwM09HVVlX?=
 =?utf-8?B?elAvajZSdG1KWVprMnp6UWpWNDhmQXZIRGRLSjFzM0Rmek1RaTV4d0NpRnAv?=
 =?utf-8?B?akppc1dyeStsN0d2WlhXZk03amI5eTVqY1dCbjMxR3R0Tk55eUtPWXovNnBC?=
 =?utf-8?B?QWpOWSsyL2V5eEFKRWlsd0FEMk9NL29HbjE5QnVWZVlPL0l1bUpoMnd3eC9y?=
 =?utf-8?B?Zk9iTkZGM082L0dlRHpUTzMzOGI4REtTYUNRUXVySStvQ0NXVHYzWHFOVGZh?=
 =?utf-8?B?dStCVnFOYnFzS1YvNThJNXA4TGRuTTZrZDB2UmVsS2ZVQ2dsZHhXeEhHZ0V3?=
 =?utf-8?B?cXN1Y2s0M0Q5VHVIMUVGTHNkblVtZWJOVXJ6Z3VpaDc5S1F4T0lHN2s5SVdT?=
 =?utf-8?B?U211UG56Zk1tRk1pNERzL2JKdUJiZDNtRnpBRm1SbkhaeVFFbVVLak5ockpS?=
 =?utf-8?B?SzF4cFVPQWhSRDBlZ3NOTkFPejRRb0dSVlRnS2ZjNVRoQ1hIMHg3UUJrYnMw?=
 =?utf-8?B?eXZqTEc5aHVvZEx1YzB2bHQ5cjMxUnNHYXhlaHpOc3FGdVZVVm1qTUJDM3FJ?=
 =?utf-8?B?RnJuRTY1eVkycWd1ZkZmclp4UWZQTUs1MllkeVdNMUliK0ZkQ01ZV3Q0S3ZW?=
 =?utf-8?B?OVQxcmtRQytjVGlIRlRpYk03OXV4bFpQZm9ZeUdoc2lWQ3M4MzlTZmVuVlRQ?=
 =?utf-8?B?aWhXNk9BbUNKUlZNTHpkWlJwa2dScVhWSTlUcjV5QkhDNmpqWS9zTVRiQkFn?=
 =?utf-8?B?bUN5dGFlNTdvZkcyS3FPeUpxQXJDRlZuMUUrMytlSzh6aktWVnZmYzBndWhW?=
 =?utf-8?B?VTFBSmxVZ3VlazE4aDByb1kzMU9zZGJBd0FSSDYxdm5FQXRGZk11WjFmR3pV?=
 =?utf-8?B?WE5KU1Badjc4aEZMN0VPNkxVRU00ZDFSd2dQN0FXRFVjci9MOEhvT1pJMlVS?=
 =?utf-8?B?YzFEcDJTWWZpaGR4eVpDRnFPK2dkeSttN2xTNHVpQlAra2txaHdIWUROTU0x?=
 =?utf-8?B?NFZ1b0lPM2ExbldzMktTYUJxaHlqZWZreDZPZE0wZmhIUlo1dzN3Q0xlNmJS?=
 =?utf-8?B?RStLNUplWFowSDU4Y3Y5RjNkQzV1WXZDVHFPMnl5VWxRRmhwSUZkVVhFdUtN?=
 =?utf-8?B?NEtKczlDMTdJWVhJSlNZSFhZVXA1dkhoTGVqZmxVN3NnR0N6ek5IN0k4cFNM?=
 =?utf-8?B?cjBDZEViMjlaOE5hK0tPaHNnUWlIZkp0ZWwrckxaY2cwZXdRYWJ4azVIV0dR?=
 =?utf-8?B?M2xqNmNPU1NRdFRJZTNwdThlTy9Xdjh4MnR5OWFIMmJ4cm1BTklscmZ5bVcw?=
 =?utf-8?B?R2hzaWg2NFZpbVhtbmZ4Uk4wak9vZGF0UUFBZzhQU21jWEIrSmMxNEtldXFJ?=
 =?utf-8?B?SExqMVRqa3ZkVjNkemxkQjZvRmpXVVBYQjV5RHloRFplOVlVUm9OdExGdmV0?=
 =?utf-8?B?clluZ3BMWXFGTXE4VDRuNWM2eWhNbUo1MXJxcXBQZ3d1WHpHSzlNcHVXdEEz?=
 =?utf-8?Q?23hPE2N246ExfaYqXwk2KVHGeOdLFUnFx85YVO+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ukcxa2dZdEc5dDJUZ2M3cy9IK0ViaWtOMEd6Mnk2VytSWkU0dXNrUklzalE1?=
 =?utf-8?B?RzJSZSt3TjRxZnBpTlZLQmlvOFV5ald1SVRUYi8xaHRQMGlUVlhuWTM4MWlJ?=
 =?utf-8?B?cmlGOHVIUXljYmRYcERDTTdJK1ZlMVlrTVhvekhwbmdDbTZjSmFlaXpVK0JS?=
 =?utf-8?B?aFRzQVRxMFlnR2lqR1E2SVhoT3JNZXFVR3pEQWtOb054eklWaThRcktxT3pX?=
 =?utf-8?B?b3ZkcEpoVS9ESEJuMXV1di9ydGRyclRTVXNzcWs0OTJkcmZza1hNajUwZzl0?=
 =?utf-8?B?emVvb2xTbVlCa2RHRjlHMTNMZ3B5ZEtDREVNcEpkSVNzczBtN21vRHd5VnJv?=
 =?utf-8?B?MDBQc0JHYXVqeWI1WWRUUFRFYmx0Ump1Sm96QkY5T29SK2xOaFJRazNzLzQ4?=
 =?utf-8?B?elQxUDlZR08vcWV1eGxWdHVYdEE5RW5ReGNoQTJvUURmRXNLaDNXSTZFbzdn?=
 =?utf-8?B?TmJHbExJSm9EMG1xM01SNzhrUmsxc1pMeGRtNlA0UEhLTXBoZ2liekgzN3Zl?=
 =?utf-8?B?Y3BwQ0M5L0M0Vm1wT1dJdkcyNWwza0xBZzhRb1l3QVZIQStHSVNSSkFMWVJ2?=
 =?utf-8?B?L1NVN0tvNEZXQ3FpODQ4OWsrOFZPV2s4UnBrWEI2U05lZjhmOWJDMTZKSzdR?=
 =?utf-8?B?eUVMWEltRUJwSTk2SkpxTmZMTFBhTFRodm1VUzd3UjQrcFZ0UkxGS1FZbVdl?=
 =?utf-8?B?b2hMaWFKc1pYcmE1ZXpjZG5BdXQyNWYyd1p6ZmJEcnpZOTY0UnF2Wkd5RlhQ?=
 =?utf-8?B?eEhrMmNONUlua1BlSmIvSENwSWkrSlVmcmxrVGFuSmd2QXhvUHJkS2Ntajlj?=
 =?utf-8?B?VzZOcTNyZjNrNE1zdEpERnppMEE0NkFCYWlzNytVSzBRQW1KVncrQ2Qvc1NF?=
 =?utf-8?B?dHcwR1BOa2tRbEpaTXZUa0Z1QXdDRW1RUVp3MUxKeklGMkNmeWo2Z3NtYkgv?=
 =?utf-8?B?U3NSRXhLdkZpbmRXbEsramoyZkNnVjhHdGloRjc0bkpvNXdJa0p4YzhjeU8x?=
 =?utf-8?B?N3FzOGNHS0FMbkI4VEpYYytLamx6cHpnNml2Y0FNMUEzdXhhSWhKK3hQVUE5?=
 =?utf-8?B?N0ZNSzNlcUFVZUFRQkc4bVJTUUh3MkcrVmpudVVxVWs1eEZMTkptTWYvQURu?=
 =?utf-8?B?MWxZOTNXdUxIdVpJN1Z2UGFqSEpaQkpkVU8rNkVQd3pkOXpaTEorUzhjZXhn?=
 =?utf-8?B?NXJQWUtHVTZzU0VYQzdCNDliYmZNa1ZjckZxS0hRY013UWVONEJ0Y0RUN01T?=
 =?utf-8?B?WnExNnVxUlo2bi82d0JmQzZzcGZYa2llc1FFSmpzcitaRmt3UWNZaGtiLzBz?=
 =?utf-8?B?U1RSbXZXSW1NSHF2cEl5ckp1ZE55a0JCQmExVENtWDdvTkw3U2VQTWx3UHFN?=
 =?utf-8?B?Z2pmWjZHSjZjd2hXSW8zZHRtYzVrazdsT2xtMFpIZU9GL2RPTEc4bkVmN0hx?=
 =?utf-8?B?N3E4UWdmSXNDVkNuUTBFZ2tRT2gxM0o2ZG5ta1M0TXZsZ1RISWNvNTZRQU1G?=
 =?utf-8?B?OFo4bFpQenFqTy9LMnQ5VDVES29YMWs2RDN6RE9NYTZScTFTNkIzbEtiRkY0?=
 =?utf-8?B?YmxUL0lQWDlEVTFTYmRxODBnS0lMMy90ejNnaUlQaXpLTXdRZ0lhRXBoVlJQ?=
 =?utf-8?B?V3VnTldoTFRZUDN5cTE3ZGgwOUtzMDBRVmd5eHZaTVV0VFcwSkhvL0ZkNXVN?=
 =?utf-8?B?bFBPRlM3TFZWcDBIWFBkeUxwUVp0SlRVT055Tk5KK2JuZDVSYVoxUXoycEhX?=
 =?utf-8?B?YlpNVmQxYSt3MDRtS2lJOEJLYU1LbkRHM0pEQ2FzTFRoWHd0Y2JTemRnVHN5?=
 =?utf-8?B?RXA3ek1OT2lCaEU1YVNMRnY0alY1K0piRFl0Rmw5ZEJPWEltNVcyOUsvV0h5?=
 =?utf-8?B?TFU5US9DYWFWdlJmU1gveTBSV2hEenJPUmtNZ0ZYYmZocjBZYkM5TnI3ZnZu?=
 =?utf-8?B?NGQwSWt3alZ5TjBLeUZOS0pYQnAyMlJyV0NkTENiNG1xUUpJQWp5dXBKdzZQ?=
 =?utf-8?B?TmxaTG0wTFZTOFpZSGJYdnRkeGx6cGlhT3dEa1VxRkYzWXYwdDdpcStUM2sy?=
 =?utf-8?B?azQyNE11azJUWk5vRUZXeHJQa0tlSElMSkx6NC81Z01iTmMyMmJzVFkrUWxo?=
 =?utf-8?Q?RWmkwmuqDxEQCLeXHc363h/Oi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8617eaa-f8b0-468f-4100-08dc8fcd7bbc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:33:08.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9+PsDCcNWy/sGudcTcV6hhR62l9nfgwdEhFpD9LG7ZAot6z3Yo8NlCoNXnylZwd+9ego4XOpXmrFGgatt9fyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090

On 6/15/2024 05:38, Rafael J. Wysocki wrote:
> On Fri, Jun 14, 2024 at 9:33 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> The UUID 4077A616-290C-47BE-9EBD-D87058713953 and _PDC methods are
>> only used on Intel platforms with HWP support.
> 
> I beg to differ.  See arch_acpi_set_proc_cap_bits() definition.

Ah I see; thanks for sharing.  I agree with you.

> 
>> Attempting to evaluate them and showing messages on hardware without
>> HWP is pointless needlessly noisy.
>>
>> Gate the code on X86_FEATURE_HWP.
> 
> Not really.

I guess this really started getting noisy in 6.6 (9527264).

Would you be open to downgrading to debug instead?

> 
>> Cc: PradeepVineshReddy (Pradeep Vinesh Reddy) Kodamati <PradeepVineshReddy.Kodamati@amd.com>
>> Suggested-by: CL Lin <clin41@lenovo.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/acpi_processor.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>> index 7a0dd35d62c9..84848b5e65d6 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -597,6 +597,8 @@ static bool __init acpi_early_processor_osc(void)
>>
>>   void __init acpi_early_processor_control_setup(void)
>>   {
>> +       if (!boot_cpu_has(X86_FEATURE_HWP))
>> +               return;
>>          if (acpi_early_processor_osc()) {
>>                  pr_info("_OSC evaluated successfully for all CPUs\n");
>>          } else {
>> --
>> 2.43.0
>>


