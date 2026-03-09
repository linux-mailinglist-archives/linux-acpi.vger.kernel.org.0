Return-Path: <linux-acpi+bounces-21544-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FJwCE7Frmn2IgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21544-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 14:04:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB423960A
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA3E43004D2C
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0D3A5E9D;
	Mon,  9 Mar 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ZDbixR+f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854442AD16
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061450; cv=none; b=jn7MddmPUrC5/nSHASOF2YaVQdPw3SVNzTG7WWledC+yc6tsaAWhPYBc4POg1TT5F/8XxKtc1W8SEHlfhHq1gAhnO8m/Q/vjMGTCM/fPhE5OI3CeKvl9wqiMt6xnYY69qAO/ZkCAOomNs0QClRoGeYFrvZ1ddhWLSiFtNAorIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061450; c=relaxed/simple;
	bh=kMuFENKvrcpOhavVjgilVQ+Ck3CSfJ/1P1GjEobS0qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FAk2KRjFsgeSp+1NFhi7gt5D/b5KJ5d844Hy8ORdpOzceZfAtZwkACEvPbI0waU5PK/Kruv7arTlgDKFRgfj8dYN4NQp8I2UcAh7jXvULVmsKfZsOYEytuqvDr0ygzixTWO2WQrUm2AoDkJnHRWud7q88AqmCkPgOr1npstNPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ZDbixR+f; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uLFOkXqvmzJ/39H+OVNHTLvduumRq9ZvMPJOa4DI+uw=;
	b=ZDbixR+fMMNKFHgGtHwjK6MtGNXUSK+7BFgOuiAOi+PAAQhiwGmEaRAOYFlFdf+UZK9YBs2Do
	CVIr4sIKAX3DRMhZPAZ2zrhunNEKrejvpEQ2kVHzOpth18VAvzxkdoNJxDLXydr0ArFogg6+PXj
	2rZj6XSWxeX+z2y0OMxDL/0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fTxsW5SPVz1T4GG;
	Mon,  9 Mar 2026 20:58:55 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D6F540561;
	Mon,  9 Mar 2026 21:04:04 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 21:04:04 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 9 Mar
 2026 21:04:03 +0800
Message-ID: <cc7f4a69-750d-4541-b7d0-4e5f9446ba6c@huawei.com>
Date: Mon, 9 Mar 2026 21:04:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: processor: idle: Add missing bounds check in
 flatten_lpi_states()
To: Jingkai Tan <contact@jingk.ai>, <rafael@kernel.org>
CC: <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>
References: <20260215002608.54934-1-contact@jingk.ai>
 <20260305213831.53985-1-contact@jingk.ai>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20260305213831.53985-1-contact@jingk.ai>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Rspamd-Queue-Id: E4FB423960A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21544-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 3/6/2026 5:38 AM, Jingkai Tan wrote:
> The inner loop in flatten_lpi_states() that combines composite LPI
> states can increment flat_state_cnt multiple times within the loop.
>
> The condition that guards this (checks bounds against ACPI_PROCESSOR
> _MAX_POWER) occurs at the top of the outer loop. flat_state_cnt might
> exceed ACPI_PROCESSOR_MAX_POWER if it is incremented multiple times
> within the inner loop between outer loop iterations.
>
> Add a bounds check after the increment inside the inner loop so that
> it breaks out when flat_state_cnt reaches ACPI_PROCESSOR_MAX_POWER.
> The existing check in the outer loop will then handle the warning.
>
> Signed-off-by: Jingkai Tan <contact@jingk.ai>
> ---
> Thanks for the review Rafael.
>
> Patch v2 as per review, flat_state_cnt is now checked after increment, and the warnings are left to outer loop to handle
>
>   drivers/acpi/processor_idle.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 81f372c64074..dc4a24560d1f 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1068,6 +1068,8 @@ static unsigned int flatten_lpi_states(struct acpi_processor *pr,
>   				stash_composite_state(curr_level, flpi);
>   				flat_state_cnt++;
>   				flpi++;
> +				if (flat_state_cnt >= ACPI_PROCESSOR_MAX_POWER)
> +					break;
>   			}
>   		}
>   	}
Above "if (!prev_level)" switch may also need to this check.

