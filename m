Return-Path: <linux-acpi+bounces-17957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A66BBEF343
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 05:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EC73BC699
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 03:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A11E3762;
	Mon, 20 Oct 2025 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="oJPTzsWT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7811429DB64;
	Mon, 20 Oct 2025 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760932008; cv=none; b=eeRMGCdy4NhOY88RL70L+IwkVZZHiFTrye227Vz9LTT25qjcQYjh9sIsj8Qisvqs/UDbSIfZllhhLsZKIjBXUGnm4ZAZ/Ow07u3Ue0/hrk2HBw2nrAQLIvcFHXY9OJcLBbawLdu6YS+17k3OxBQjbe6ges72Tqyfe9Kw6PloQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760932008; c=relaxed/simple;
	bh=iABrdS59ZBU4YHTm5ISf0PfyxAAqtPHL1MA1HLeuBqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dwSOLDbt2SaO1DTZH+GMhAZYlqytJNe/VqDlC5tI5yB/SQPmHfHIrcomA3yBvHuZ6XPTiuMKulBM8HVsyOwzGBctxnDF+NywCordMyAJ5zbqwOjQ01z9FaGuOzPWrzB00Ha03EdOcsPmd7N1lYxh5wl7QH+gv+pzOkHd0+TGUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=oJPTzsWT; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bDZQiErnIgzXG7MxUHsOCjYVCCcjyBfq4X2AfDHmv7U=;
	b=oJPTzsWTk2+N6N+1nrMFIqWn+foijoQW6PZTsAv2la39dooU9ZBzjqlc8d/Z7WybLEfZn7HVA
	S+jV+KgD5zpMQyzjkhDczOS+oGMse3hbeJjYo5GSvMB3cwC7dWkKyHoMKfkmg0yZsX5dBkx5mk2
	pnwljSBYQunvAlVDM9kjclQ=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4cqhDW1HR5z1cyQv;
	Mon, 20 Oct 2025 11:46:19 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FA62140142;
	Mon, 20 Oct 2025 11:46:42 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 11:46:42 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 11:46:41 +0800
Message-ID: <6b3ca901-025d-44b8-9558-6ad5a491807e@huawei.com>
Date: Mon, 20 Oct 2025 11:46:37 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] Revert "mailbox/pcc: support mailbox management of
 the shared buffer"
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Adam Young <admiyo@os.amperecomputing.com>, Robbie King
	<robbiek@xsightlabs.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Cristian
 Marussi" <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-1-0fba69616f69@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-1-0fba69616f69@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/17 3:08, Sudeep Holla 写道:
> This reverts commit 5378bdf6a611a32500fccf13d14156f219bb0c85.
>
> Commit 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
> attempted to introduce generic helpers for managing the PCC shared memory,
> but it largely duplicates functionality already provided by the mailbox
> core and leaves gaps:
>
> 1. TX preparation: The mailbox framework already supports this via
>    ->tx_prepare callback for mailbox clients. The patch adds
>    pcc_write_to_buffer() and expects clients to toggle pchan->chan.manage_writes,
>    but no drivers set manage_writes, so pcc_write_to_buffer() has no users.
>
> 2. RX handling: Data reception is already delivered through
>     mbox_chan_received_data() and client ->rx_callback. The patch adds an
>     optional pchan->chan.rx_alloc, which again has no users and duplicates
>     the existing path.
>
> 3. Completion handling: While adding last_tx_done is directionally useful,
>     the implementation only covers Type 3/4 and fails to handle the absence
>     of a command_complete register, so it is incomplete for other types.
>
> Given the duplication and incomplete coverage, revert this change. Any new
> requirements should be addressed in focused follow-ups rather than bundling
> multiple behavioral changes together.
>
> Fixes: 5378bdf6a611 ("mailbox/pcc: support mailbox management of the shared buffer")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Yeah, there are some duplications. I remember I also mentioned before.
Acked-by: lihuisong@huawei.com

