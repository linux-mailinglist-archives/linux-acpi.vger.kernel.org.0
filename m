Return-Path: <linux-acpi+bounces-12072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F2A5BEC3
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF93F3A96F9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBB32528FD;
	Tue, 11 Mar 2025 11:19:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A6253F11;
	Tue, 11 Mar 2025 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691967; cv=none; b=PJPh58e9pqmopkzgx06bU+2lJxuKxekz1QE6iTqy+JUC+yuJ9ToH9Nchc2SqEhsfi7QAiXkEIy2mL51I7NlktHBYF/eQkdEPuM4bbI86SgBa00H7uKXiCa8EEF15+KiB9cmhIXeqWAvO4aXMe8HOrAmMM/zFlO+O5TKteok5res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691967; c=relaxed/simple;
	bh=7N0ai0DUioHf9S6UyzHZwS3HbY6TQQWMWg1rC/cVr5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gURoin1U5SrYQxTKea3rfFfpON+KnYOwsCSHSOTndhVt1IASO+4dJ17HVhWbhglZ5lDbbF4nOyxkJ42eKJip+bw5URqHtclEIBjyy8ykVw3M/9NXpgvEIJfLXwqKaSCP+4n/00FxOYCX02FbxpqrDm9VzS3PtSln3tl4l63pEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZBrl90Qc1z2RTQC;
	Tue, 11 Mar 2025 19:15:01 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 62756140203;
	Tue, 11 Mar 2025 19:19:21 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 19:19:21 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:19:20 +0800
Message-ID: <52609085-af53-2653-2927-05414cacac3d@huawei.com>
Date: Tue, 11 Mar 2025 19:19:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 02/13] mailbox: pcc: Always clear the platform ack
 interrupt first
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-2-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
> The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
> for command completion flags and any error status before clearing the
> interrupt.
>
> The below sequence highlights an issue in the handling of PCC mailbox
> interrupts, specifically when dealing with doorbell notifications and
> acknowledgment between the OSPM and the platform where type3 and type4
> channels are sharing the interrupt.
>
> -------------------------------------------------------------------------
> | T |       Platform Firmware         |    OSPM/Linux PCC driver        |
> |---|---------------------------------|---------------------------------|
> | 1 |                                 | Build message in shmem          |
> | 2 |                                 | Ring Type3 chan doorbell        |
> | 3 | Receives the doorbell interrupt |                                 |
> | 4 | Process the message from OSPM   |                                 |
> | 5 | Build response for the message  |                                 |
> | 6 | Ring Platform ACK interrupt on  |                                 |
> |   |  Type3 chan to OSPM             | Received the interrupt          |
> | 7 | Build Notification in Type4 Chan|                                 |
> | 8 |                                 | Start processing interrupt in   |
> |   |                                 |  pcc_mbox_irq() handler         |
> | 9 |                                 | Enter PCC handler for Type4 chan|
> |10 |                                 | Check command complete cleared  |
> |11 |                                 | Read the notification           |
> |12 |                                 | Clear Platform ACK interrupt    |
> |   | No effect from the previous step yet as the Platform ACK          |
> |   |  interrupt has not yet been triggered for this channel            |
> |13 | Ring Platform ACK interrupt on  |                                 |
> |   | Type4 chan to OSPM              |                                 |
> |14 |                                 | Enter PCC handler for Type3 chan|
> |15 |                                 | Command complete is set.        |
> |16 |                                 | Read the response.              |
> |17 |                                 | Clear Platform ACK interrupt    |
> |18 |                                 | Leave PCC handler for Type3     |
> |19 |                                 | Leave pcc_mbox_irq() handler    |
> |20 |                                 | Re-enter pcc_mbox_irq() handler |
> |21 |                                 | Enter PCC handler for Type4 chan|
> |22 |                                 | Leave PCC handler for Type4 chan|
> |23 |                                 | Enter PCC handler for Type3 chan|
> |24 |                                 | Leave PCC handler for Type3 chan|
> |25 |                                 | Leave pcc_mbox_irq() handler    |
> -------------------------------------------------------------------------
>
> The key issue occurs when OSPM tries to acknowledge platform ack
> interrupt for a notification which is ready to be read and processed
> but the interrupt itself is not yet triggered by the platform.
>
> This ineffective acknowledgment leads to an issue later in time where
> the interrupt remains pending as we exit the interrupt handler without
> clearing the platform ack interrupt as there is no pending response or
> notification. The interrupt acknowledgment order is incorrect.
>
> To resolve this issue, the platform acknowledgment interrupt should
> always be cleared before processing the interrupt for any notifications
> or response.
>
> Reported-by: Robbie King <robbiek@xsightlabs.com>
> Reviewed-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
>

