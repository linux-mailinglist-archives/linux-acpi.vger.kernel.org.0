Return-Path: <linux-acpi+bounces-20754-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC2dD975emkwAQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20754-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 07:10:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4EFAC296
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 07:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B45D3005178
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 06:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6083783B6;
	Thu, 29 Jan 2026 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="FnbJV8H7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA3377577;
	Thu, 29 Jan 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667032; cv=none; b=RwmEqS/2qRbN8IjUpd12AuPRzO4kx3fttfC1UoXT7mMEbbKhvYjzSRNicggBxXpBzbFiR3dkCRySoo8HLB1taOdyfSoWpA+/H8V14jDgw207e4GPmKyBdGZihECTs6zkQP567bCzvYKpDXo3dymcBwQA7LyS6Ng+YKVmgsgEH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667032; c=relaxed/simple;
	bh=E37O0b9tT7MpZ4b2z4no/ca3iCBIyDyXD6FBHu0bWPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AjZZKOnAqKQU227ZvdT47xHfoF7nMDftB9lUwk4d6bjLPZGhlTmf9GUiGybHP84LO/VlYL68jpfZfmEkW0yHtu90aJCj1UGyU3/UhLkPJcG3aTSnkoD5d+nJjqIYjn/RXLk+uyL1D3GnTy/vGbGm3zVNE1A7Z6KlkFS6rmV0Q18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=FnbJV8H7; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=E37O0b9tT7MpZ4b2z4no/ca3iCBIyDyXD6FBHu0bWPk=;
	b=FnbJV8H7ee49z9mUKoF8NAq7blo744cdaPGv3zWwtmAfQxsX+HUJANjjYPXVmu34Fl1pzM6Ey
	JLSxQeDZrIyiB9KCkk3LaUtkzTAE4EeBeAAQuSiJfc9V79CQt78kd10S1vhHScehKxDmGee7/+d
	jqUbJv3CuWFiDQX2A8NpgVM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f1pYN052Wzcb4Y;
	Thu, 29 Jan 2026 14:06:16 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 751B320168;
	Thu, 29 Jan 2026 14:10:27 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 14:10:27 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 29 Jan
 2026 14:10:26 +0800
Message-ID: <fce679aa-3fd3-409b-97cf-15a32bcb0b22@huawei.com>
Date: Thu, 29 Jan 2026 14:10:25 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: Remove mailbox_client.h from controller
 drivers
To: Sudeep Holla <sudeep.holla@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Beleswar Padhi <b-padhi@ti.com>,
	Andrew Davis <afd@ti.com>, Yuntao Dai <d1581209858@live.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mailbox@lists.linux.dev>, Peng Fan <peng.fan@nxp.com>
References: <20260128-mailbox-v1-v2-1-54936bb08f15@nxp.com>
 <aXoFhMUKIvsP-DVd@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <aXoFhMUKIvsP-DVd@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FREEMAIL_CC(0.00)[gmail.com,ti.com,live.com,vger.kernel.org,lists.linux.dev,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20754-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,h-partners.com:dkim,huawei.com:mid,huawei.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9A4EFAC296
X-Rspamd-Action: no action


On 1/28/2026 8:48 PM, Sudeep Holla wrote:
> On Wed, Jan 28, 2026 at 08:32:10PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> mailbox_client.h should be used by mailbox consumer drivers, not mailbox
>> controller (provider) drivers. The affected drivers do not use any mailbox
>> client APIs, so the include can be safely removed.
>>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
LGTM,
Acked-by: lihuisong@huawei.com

