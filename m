Return-Path: <linux-acpi+bounces-16716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0741B54CC8
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82663AA4013
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB58301012;
	Fri, 12 Sep 2025 11:57:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10930274A;
	Fri, 12 Sep 2025 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678249; cv=none; b=ROlCKV5tjhNrkjIVH1nu8y8HoYjLluRJ2PKqlFbg5SdBqQLC8rCMkt07QhvOroqv74Q9wURjKS6Ig/3FHwTo8MqEI07xtmq95AS6euOOO4xJvSSdVi/yEYXMaz9E5GlSBtIXHwiaDlfoGUu3smKjQVzihL8RGauq+4wnEHGEX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678249; c=relaxed/simple;
	bh=jxwn4iF8hNWaAU6J9N2S0KXwUK3vQgiVZmCMjYcCq+Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbMnLW28bwBwU7ZPj+lRZ7j6L+1hcsvklbjI5xDA7MwOnGk+/B7YYtwGe8RGxRlJtxGNTsNns7wze0yXvmz1G6oUW9XmaksB02O5unA+F8HC7PijUGaHHhCYHQGRj8sDZZpe4eB1n1/t4DRPKWf45/fQYt6j8wJLOcHSTOpXIsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNXqm16PBz6L5Ch;
	Fri, 12 Sep 2025 19:53:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D648C1402A4;
	Fri, 12 Sep 2025 19:57:24 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 13:57:23 +0200
Date: Fri, 12 Sep 2025 12:57:22 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH v2 16/29] arm_mpam: Add a helper to touch an MSC from
 any CPU
Message-ID: <20250912125722.0000373e@huawei.com>
In-Reply-To: <20250910204309.20751-17-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-17-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:42:56 +0000
James Morse <james.morse@arm.com> wrote:

> Resetting RIS entries from the cpuhp callback is easy as the
> callback occurs on the correct CPU. This won't be true for any other
> caller that wants to reset or configure an MSC.
> 
> Add a helper that schedules the provided function if necessary.
> 
> Callers should take the cpuhp lock to prevent the cpuhp callbacks from
> changing the MSC state.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

