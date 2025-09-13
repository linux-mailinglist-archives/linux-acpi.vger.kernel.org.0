Return-Path: <linux-acpi+bounces-16844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA3B55F14
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 09:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F90E1B21724
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Sep 2025 07:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01102DCF44;
	Sat, 13 Sep 2025 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rgv/6+cs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015381E834F;
	Sat, 13 Sep 2025 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757747245; cv=none; b=H4szrsz1CPVAeCTzyk3nAhIbXkO4D/vdvqES7ORQ/1yTol0V3ibHzGNItGElO2OCoyQ8dikkPZ9uojdanHPvA//exRzhNEhNHr6G7Pec3EMr+H2yofiM2ZtLwXVxPMIhfoY7PQzTadlY2et20l9v3SpPpb5ltuJGblLHICi5EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757747245; c=relaxed/simple;
	bh=+AZ//c6x0d1bUNOy/2o8HW9ThgfU17FCJDuM5iD7Mj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYb40VJU+/2QNqLs19PVVLPgs283Skqj6XLYuhHlCO26wSax8wHIjWj1BUIc75HpVvi8u88fjDpSmRPnBmTvMxz57vmh5/bNbh60SMpAng6NZ6S5YIH76tavhXEUB2wSZoB4heZsuLElJnxtiIO0B4LJUVLiw9TCORpj0PRVHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rgv/6+cs; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757747239; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aY6ckG4GWxhGkj1njVbjeVmXNQLhy3eN2kyxIuM00I8=;
	b=Rgv/6+cs3G9lGWBLo3LaZvQGzPcTyJXkXnxKRHIiO3k1fhJMird6NCdOObKq0j7GrWOZ/uzIuPZlw7pnvbMWitZVGKOTKv7K0p1/V8+Wa7MgbJvfxsT9iDSsmvxbRvOQLjGEJWs526kJTamGF8oyEFjgLQRZ/IV6x58tE3AtXLs=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wnt015o_1757747234 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 15:07:18 +0800
From: cp0613@linux.alibaba.com
To: rafael@kernel.org
Cc: cp0613@linux.alibaba.com,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: SPCR: Support Precise Baud Rate filed
Date: Sat, 13 Sep 2025 15:07:16 +0800
Message-ID: <20250913070716.16533-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0j1xJ04dWZWKaM_jxZ9aKfZWg40kvxS4s+meWitasRJng@mail.gmail.com>
References: <CAJZ5v0j1xJ04dWZWKaM_jxZ9aKfZWg40kvxS4s+meWitasRJng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 16:02:58 +0200, rafael@kernel.org wrote:

> > +       if (table->precise_baudrate)
> > +               baud_rate = table->precise_baudrate;
> > +       else switch (table->baud_rate) {> 

> Please do not change the indentation below.> 

> > +               case 0:
> > +                       /*
> > +                        * SPCR 1.04 defines 0 as a preconfigured state of UART.
> > +                        * Assume firmware or bootloader configures console correctly.
> > +                        */
> > +                       baud_rate = 0;
> > +                       break;

I got it.

