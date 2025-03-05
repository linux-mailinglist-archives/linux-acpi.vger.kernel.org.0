Return-Path: <linux-acpi+bounces-11821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2967A4F6BE
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 06:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CEC188C637
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59B1D86C6;
	Wed,  5 Mar 2025 05:57:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057211386B4;
	Wed,  5 Mar 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154264; cv=none; b=HTGfUyiLj+OUGkS1o+qMYLkpjhqw5n0DKD4AzOQO9vDWDukJauEfcF250omspPXV7/0hrsSy+8rB407R8zMAbQwmqHNLoA7KiXOWZQN7eJi4DXbSgFaKoWfn9G2E/z140pTRe0XuU4oNmP2SDSNIt7pVuigMgYachWac+u8cRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154264; c=relaxed/simple;
	bh=MCoIpFjW1ePBMmnAoirm06pI4rMFWC7wHlHMxgACxC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t0L/TppvRYdhSTw2l74szhdjAiAWLLAAz71KzLhlaBOelKJyFkT1B/yIA4MSuP4KRvRbGE3TMiB8+IYxu4wcvqjeMTriOP1GpvDz5Sf8yMFvWm40Moc4lycsW/qAo/fDDlzNuuCx/ul4G4Le8u6voM0H/O3j/QcvhOTAmivs1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z71xz36GdzpbYl;
	Wed,  5 Mar 2025 13:56:07 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2263514037E;
	Wed,  5 Mar 2025 13:57:38 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Mar 2025 13:57:37 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Mar
 2025 13:57:37 +0800
Message-ID: <db214092-9778-ac0c-0d6a-ef95bd468667@huawei.com>
Date: Wed, 5 Mar 2025 13:57:30 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 04/14] mailbox: pcc: Return early if no GAS register from
 pcc_mbox_cmd_complete_check
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-4-3b44f3d134b1@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-4-3b44f3d134b1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/3 18:51, Sudeep Holla 写道:
> pcc_mbox_cmd_complete_check() accesses pchan->cmd_complete.gas to check
> command completion status. Even if GAS is NULL, pcc_chan_reg_read() gets
> called which returns success doing nothing and then we return.
>
> Add an early return if pchan->cmd_complete.gas == NULL before performing
> any operations.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
Acked-by: Huisong Li <lihuisong@huawei.com>

