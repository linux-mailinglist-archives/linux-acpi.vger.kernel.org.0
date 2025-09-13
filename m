Return-Path: <linux-acpi+bounces-16843-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36FCB55F12
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2850D1B21F41
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923C52DCF44;
	Sat, 13 Sep 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fonBiPMZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4045231830;
	Sat, 13 Sep 2025 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757747197; cv=none; b=iQQNZwhbmqvNDjB8LKV0Be/gIGOBuJYdhXRsALePTenJ42UFGuPXdYIYoRPHvS0GvPTlSF5piPJHcFHEZ0GjaA/t325XESFh7XNvz6UxPUR+3Af+goZvkte1quuSlIhLO2IYM6Z13YpoAbL6mcyjnf4cO1HVu1odkw525jweXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757747197; c=relaxed/simple;
	bh=Bgch2YkQ/RkK/yGpZMKUOEZpUfwY6gFr0Q1AofqHZgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXwWuJErcuobNZcgw5/W6WFZojB1LHokkUPSyCFe9bFD7M811RXjuW4F9Ysbsu38/IWNzEoKe/ZBDHl8x9TpAlBG8qP2cwRSPsxI3yEFH3VIG7FJNuheBUKHtrXJjaz7goBlW1e84Rv0LZYLW1Z+5PHYtg5f46FaLYZAs1kcG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fonBiPMZ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757747190; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nkf4H7I0VEn3jHbUNHORiDwSeX6tVUGUnC2xuwx5+JI=;
	b=fonBiPMZ2NVmS8fFEBZUOiat1OZC70FBkiz+nze8YzzMaHQK9Z+SIAEURcpEg3KAqO/ouGwx3JpVviMzh3VI0vPUTl79StHMQ6Lw/EZbUK3bWnvb189pcwPKRPqDM6YCSbFDlB1w7erZrvJBYeTaNctytGaTvCNniJXLQJWbYQ0=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wnt00mT_1757747183 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 15:06:30 +0800
From: cp0613@linux.alibaba.com
To: guoren@kernel.org
Cc: cp0613@linux.alibaba.com,
	jeeheng.sia@starfivetech.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH] ACPI: SPCR: Support Precise Baud Rate filed
Date: Sat, 13 Sep 2025 15:06:25 +0800
Message-ID: <20250913070625.16332-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJF2gTTn6PhqjOPAxVfSy_8avb1_7BAeqOsFxPnvmZ3KF8sqog@mail.gmail.com>
References: <CAJF2gTTn6PhqjOPAxVfSy_8avb1_7BAeqOsFxPnvmZ3KF8sqog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Sep 2025 13:24:21 +0800, guoren@kernel.org wrote:

> > It contains a specific non-zero baud rate which overrides the value
> > of the Configured Baud Rate field. If this field is zero or not
> The spec states that it would "override" the baud rate. That means it
> should happen behind the table->baud_rate or firmware still needs to
> give out a legal Configured Baud Rate for precise_baudrate.> 

> Then, we move these:
> +       if (table->precise_baudrate)
> +               baud_rate = table->precise_baudrate;
> behind the "switch (table->baud_rate) {}".> 

> Right?> 

> > present, Configured Baud Rate is used.

OK, I think "override" means priority in a sense, there is no need to do
an overriding action in the behavior.

