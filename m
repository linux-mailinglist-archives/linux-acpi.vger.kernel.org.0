Return-Path: <linux-acpi+bounces-17959-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A08BEF371
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 06:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17E024E04D5
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 04:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16752BD031;
	Mon, 20 Oct 2025 04:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="mczMPX6c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBCA1DE4E0;
	Mon, 20 Oct 2025 04:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760932953; cv=none; b=W1F1SIL6U2wy2kgKJtfkQTT0WvrgRQKF8xMQFMIEn6ggYMPL1UH1ybEZHuW7BKojP93HgakppLU7wfmm370djNZcmUaK8MTnnG1gWdegGddz5dlt2vQXupbFvrceB3GOndUpOKYZpvLRYP0Pwa2/qkrXsQttXacVlv5TMurwtvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760932953; c=relaxed/simple;
	bh=ZbZMSSqqrf9dofraKXdqe751VAl1uxDvcJPLK379H+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SjCofd/GYKIEbKiHgEv++txdqida2WUcqZ9TAjv/WzxryGnK1a0bpJ0HlYhWY8YMht05IEQlGmy9ZiD0rI/UDxxSlwUVeP9ANczQC+FAd2D+yBBXASQlPsNQOWRkl94MhRAGwAGECJ9MjvpRVF1tu4tb5xcGGKFSgOCzO6X/Mhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=mczMPX6c; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4dg7dx3WRC0rsC0c/dFcLy+5Q+cE5qOhYaZYSoLWT3E=;
	b=mczMPX6cvQjmG9TEMk2XjKUhHA+iZoL3IeyostO+zfEntkh2EO0OX2tC2FNb+My4SoM5FTUu2
	9HYlukogi8V6CNuq8pRVp6vrWCW/4yoymGGeg9aSLGF2e58j3v1TUCHYUAMlOPlGvlRWBWXV/ZK
	+NZ1Wyva2J3Pm4D+WATpvBs=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cqhZf2dwmzLlYP;
	Mon, 20 Oct 2025 12:02:02 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 967301A0188;
	Mon, 20 Oct 2025 12:02:25 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:02:25 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 12:02:18 +0800
Message-ID: <685b549a-2119-45a4-8996-89e33f47bc5a@huawei.com>
Date: Mon, 20 Oct 2025 12:02:17 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mailbox: pcc: Set txdone_irq/txdone_poll based on
 PCCT flags
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Adam Young <admiyo@os.amperecomputing.com>, Robbie King
	<robbiek@xsightlabs.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Cristian
 Marussi" <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-3-0fba69616f69@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-3-0fba69616f69@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/10/17 3:08, Sudeep Holla 写道:
> The PCC controller currently enables txdone via IRQ if the PCCT exposes
> platform capability to generate command completion interrupt, but it
> leaves txdone_poll unchanged. Make the behaviour explicit:
>
>    - If ACPI_PCCT_DOORBELL is present, use txdone_irq and disable polling.
>    - Otherwise, disable txdone_irq and fall back to txdone_poll.
>
> Configure the PCC mailbox to use interrupt-based completion for PCC types
> that signal completion via IRQ using TXDONE_BY_IRQ, and fall back to
> polling for others using TXDONE_BY_POLL.
>
> This ensures the PCC driver uses the appropriate completion mechanism
> according to the PCCT table definition and makes the completion mode
> unambiguous avoiding mixed signalling when the platform lacks a doorbell
> flag set.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
LGTM,
Acked-by: lihuisong@huawei.com
>

