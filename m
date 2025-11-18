Return-Path: <linux-acpi+bounces-19024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F1C6A5E3
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C435386DE9
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB7364EA5;
	Tue, 18 Nov 2025 15:41:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC59273805;
	Tue, 18 Nov 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480496; cv=none; b=h4AKqJ1BKf6xIjmfsCpZRw1jL+N1Rt1eJhOToOSfdcXgUCIni+DD30Cyyjt7aNCf9HQIhOjsk5jXFKXTAHwGKftqYk5AYTEvDWerSjTJwHiknMcRM5QLReE6AHpFZCcGhAW7IYSfUxKLiYTaMq0S2oLaDINrRfit/+rsmCqp/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480496; c=relaxed/simple;
	bh=K62tQV4uWGLkSKD0Q0GkV/FvabiRoq+FRuA/CocGsjs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOND0vu/9zBq/sTekoBacgRdIWfrfPZh0gWd7WOenDa6kKMDM/98h0x8Rb6y8OiuMOavB25+13aRNWqNAMN1PWVN7DG9ezMEDzYS6f/sdHFqnn9/CfAc9yjgmkkEW++DCJDgqMOxLsF4BBWQ2b6WbfAFS2ErPpsMysMF/byZAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9pjp1WgzzHnH6q;
	Tue, 18 Nov 2025 23:41:02 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 42ABF1404C4;
	Tue, 18 Nov 2025 23:41:33 +0800 (CST)
Received: from localhost (10.126.168.5) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Nov
 2025 15:41:31 +0000
Date: Tue, 18 Nov 2025 15:41:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
Subject: Re: [PATCH v5 34/34] MAINTAINERS: new entry for MPAM Driver
Message-ID: <20251118154130.00004fc5@huawei.com>
In-Reply-To: <20251117170014.4113754-35-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
	<20251117170014.4113754-35-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 17:00:13 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

> Create a maintainer entry for the new MPAM Driver. Add myself and
> James Morse as maintainers. James created the driver and I have
> taken up the later versions of his series.
> 
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
FWIW
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Btw, I think the only one I didn't tag was 33 and that's just
because I'm too lazy to check all the test cases :)

Jonathan

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..ec9b2b255bef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17463,6 +17463,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
>  F:	drivers/video/backlight/mp3309c.c
>  
> +MPAM DRIVER
> +M:	James Morse <james.morse@arm.com>
> +M:	Ben Horgan <ben.horgan@arm.com>
> +S:	Maintained
> +F:	drivers/resctrl/mpam_*
> +F:	drivers/resctrl/test_mpam_*
> +F:	include/linux/arm_mpam.h
> +
>  MPS MP2869 DRIVER
>  M:	Wensheng Wang <wenswang@yeah.net>
>  L:	linux-hwmon@vger.kernel.org


