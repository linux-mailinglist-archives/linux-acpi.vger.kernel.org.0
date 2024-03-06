Return-Path: <linux-acpi+bounces-4128-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B79F6872C60
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 02:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E335D1C21873
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 01:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986996FD9;
	Wed,  6 Mar 2024 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xFRfuKbt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432382CA7;
	Wed,  6 Mar 2024 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690185; cv=none; b=IgKTvwJZh5Hs1xqTB+4YkLG2377SBCmTmodv1QkiPuPvYNmyIYxY2WeYO2JjTXEedjBSqAA8CiW7T5KTGDAYLVj5pwyUVAi1LcS6h/PIBgyP5/a0UNWOQ8ivrsW3bl2acSVljjubJwqOtoqZQbeZmF6LIwRhP9m2M4Z8NoltGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690185; c=relaxed/simple;
	bh=8sk0HCcX1wc5hSCINxbdUaIw9fDpH3qWBaqAEXYOXtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BE0RdD1Zp/Kep1Y7hlcFnkLoXC0l5VuqpdK/xt8RgNk0Eam+PPCdr5ShaywnIbQaNs17cDrT4dYEP8ZsgDW24nKqFcWsP/JkM4QaIQpjxH8dcOfasRKFRjBxmhh08QqjC/aatVhlIqtEa6Yg1Hke0YaKYRNe+4VFLC+PHCkoBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xFRfuKbt; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709690174; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qkIKMCtwc/WmcYRCMjAIo122MYBcIAn7tcIWndOwawQ=;
	b=xFRfuKbtcFTFksMjThLVHNRWBzswEI0lBZxLpECAZwK+uKxApzomrCJgPeToVUev5VVt4/6/TOBLgeVx1VZre4RzcEuNBQ/z0a6rJ/e420apE5b8sru2mQFyuZmHMFlvQpjZ3NDg5nlY6w4SwWOdEt//IUiFsqr3ysl60nGzlIs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=herongguang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1vbkGI_1709690172;
Received: from 30.221.99.67(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0W1vbkGI_1709690172)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 09:56:13 +0800
Message-ID: <3d2d3f01-7af6-484f-947f-c0b1caa2974b@linux.alibaba.com>
Date: Wed, 6 Mar 2024 09:56:12 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cstate: fix mwait hint target cstate calc
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: jacob.jun.pan@linux.intel.com, lenb@kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, shannon.zhao@linux.alibaba.com
References: <07b62879-2445-4b0d-880a-be01a44820f8@linux.alibaba.com>
 <CAJZ5v0iggVOU4_o2qwe92e37r35ovLMGypvLqNevgydEdfNJEw@mail.gmail.com>
From: He Rongguang <herongguang@linux.alibaba.com>
In-Reply-To: <CAJZ5v0iggVOU4_o2qwe92e37r35ovLMGypvLqNevgydEdfNJEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/3/6 4:30, Rafael J. Wysocki 写道:


> Also, your email client mangles white space, so please consider using
> a different one for sending patches.
> 
> Thanks!

Ok, it turns out it is in Windows Terminal that copy will change tab to 
white space, I will pay attention to this from the moment, thanks for 
your reminder.

