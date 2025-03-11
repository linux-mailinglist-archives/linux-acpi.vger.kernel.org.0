Return-Path: <linux-acpi+bounces-12074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C723A5BEC9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971E67A85FF
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4344A236453;
	Tue, 11 Mar 2025 11:20:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665B29A1;
	Tue, 11 Mar 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692035; cv=none; b=IOLHXk14QsdfNudSwtCgAmxoK6NxwYTqKHPv7xhVEwYbLpvSv/NiWLZtduBzxuSxMirtLr+F/A+K0rC4Cb9pEHK4yTIl0mvE1CvvnNhl/UMdaxq/OYhmyWQvOccauoQva7qzCkv1wCfLIORvNvHTsvVQa24tfxTjQPl2OL8Bvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692035; c=relaxed/simple;
	bh=JHms5rRxyKYX5WTvns8fxT9S6nrKbRB04BFrU9h/ECU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hStW93WCyKZQW+qwUQIpJhz14j47Hss/b9XWQq5TIgibHyjuit1OEmWveLarU98gIDiF/4FHCZM5DPEo1cgqWRQ92+CJx7RN8DWgCm3wCL/BJ9XuScZDVd9jOulV+IaUE9c1RVJKKSYmnae2jP6S0V935yqnYX0kIeSo8FJz20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZBrnj6b1vzDsx7;
	Tue, 11 Mar 2025 19:17:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D4881800CD;
	Tue, 11 Mar 2025 19:20:24 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 19:20:24 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:20:23 +0800
Message-ID: <3d51d249-7e87-0bf3-c756-f46cd4892745@huawei.com>
Date: Tue, 11 Mar 2025 19:20:23 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 04/13] mailbox: pcc: Return early if no GAS register
 from pcc_mbox_cmd_complete_check
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-4-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-4-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
> pcc_mbox_cmd_complete_check() accesses pchan->cmd_complete.gas to check
> command completion status. Even if GAS is NULL, pcc_chan_reg_read() gets
> called which returns success doing nothing and then we return.
>
> Add an early return if pchan->cmd_complete.gas == NULL before performing
> any operations.
>
> Acked-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
Tested-by: Huisong Li <lihuisong@huawei.com>
>

