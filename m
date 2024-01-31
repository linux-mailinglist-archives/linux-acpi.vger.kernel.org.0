Return-Path: <linux-acpi+bounces-3106-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF118437FB
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 08:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22AC1F213F2
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BB51027;
	Wed, 31 Jan 2024 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEGGth9S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51255E56
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2024 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686633; cv=none; b=sFR7My+ePC7LyjkJ4oRObq7g4skrAB6UOyI7mH1h9jd0tva+qdieJkz/15ojbuexjYj/q+TRlGeVyeViRptuLSwvaOnjVgQW8V7FsSMrJx/nqbI0mlWV6s0TwL0pCTgh+BXT6Rtd8PVIaiVpi9/Fuwze64L0K4ah2RWCDYqmJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686633; c=relaxed/simple;
	bh=dSmKKf/WeDv4LJRg3gWw9QTmx6d3YoGDqDwXgzog1MY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SZn+qclnUcGRK566kDid48EZFd/C0nYtF+FFgVOMy59H9qCnJ6EG/SDmOSyUi03HTMG/5V16AfiYocFuFb1KTcuF8KhiiuUSL5hwzxeSBAlEqWOXr7vwniRrt4cAaEsrFb4/eKVKH8+JDHyAmIVmZXW4BafZBXD75MTeU8fnT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UEGGth9S; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5110fae7af5so3618542e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jan 2024 23:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686630; x=1707291430; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLMRt3qFOG0a8Po/7OdoUq0bxymKEiiDC9OSOLAk7ao=;
        b=UEGGth9Siei1tu8QoReUrKeGJXKXQPWamyABDgqeba5pEEoXFNeKNF6Bruro/IdO7H
         k23xVRfU7k4Bp9fZD2Lg7JyXxUtL/sM2fEZ68ncnG+CpAg1fQFkk5H5m88FwH2QVSLlV
         EGoPbOHeZWvRFp5vzpwKpDo+3iR6aDew+rhUb/YRIl1PoZ6YFeu8htTW5iSFnzeARwj+
         k1ZrsoZNc2RHbV7bsuomjW7k5OehUJuwdt07MnhCKt6k9DIBBUXCcCkW4re5D2vrWkBH
         KtvbY8ZYwOPrr/OFOAjC2lVRVhMgPhDEQPKq92/Mj478Np4XnViinQSsBxYsbAmUYDGm
         lKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686630; x=1707291430;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLMRt3qFOG0a8Po/7OdoUq0bxymKEiiDC9OSOLAk7ao=;
        b=uY1I+VhltPvXlLbQjTgZqZ8gP1pS0YgnTZOI/R7qAIWWipXO3YvLHldvyZl6QtC49y
         7rM+AAQdVzmkc5JFIy0cDbXj22/Jnub01+zXINy5tDyLsSYjl6l6O3Tvn8fL+29ozPob
         hEMhCWYd5UXdbxKUX4xpixy0EpVQuCKdc/m3VQdfIMkEC6qU54vEI1BgTiCpn4sOxC+E
         KtXyQtraw7aZwqgPckeO6Jys2edUwvHxrYpt6ky0omSDJ52OR0OfD4qixvaNwyA0BdLr
         EVnkML4UuIbsOo6Nr/wk4dRSPJ30nhb0fA9an9LFIY3+igCK0GtYGl8Abcu+BgY2jMoX
         idew==
X-Gm-Message-State: AOJu0Yw3QsYB/prLC9+gTilzf7a+bA4H1fHFMtWvwN+owLxcSAs1PhEv
	uEG9HnwAemGoCfioRkHptmTiB71gFqyTG959X4QojboFKYWyhVQhVMa7hz98XggO/ZtvgEtreXJ
	+
X-Google-Smtp-Source: AGHT+IGDuUVJ7SJy86uDBsVjdQDeFtrNQX9BgOCvYCAE6CRf6C6mwkc28YKDfMK3jfy0hVs8ckN/cw==
X-Received: by 2002:a05:6512:786:b0:50e:ccfa:56c3 with SMTP id x6-20020a056512078600b0050eccfa56c3mr485875lfr.34.1706686629863;
        Tue, 30 Jan 2024 23:37:09 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id x12-20020a05600c420c00b0040ef9ffd3c1sm710446wmh.19.2024.01.30.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:37:09 -0800 (PST)
Date: Wed, 31 Jan 2024 10:37:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ira.weiny@intel.com
Cc: linux-acpi@vger.kernel.org
Subject: [bug report] acpi/ghes: Process CXL Component Events
Message-ID: <b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ira Weiny,

The patch 671a794c33c6: "acpi/ghes: Process CXL Component Events"
from Dec 20, 2023 (linux-next), leads to the following Smatch static
checker warning:

	drivers/acpi/apei/ghes.c:724 cxl_cper_post_event()
	warn: sleeping in atomic context

drivers/acpi/apei/ghes.c
    709 static void cxl_cper_post_event(enum cxl_event_type event_type,
    710                                 struct cxl_cper_event_rec *rec)
    711 {
    712         if (rec->hdr.length <= sizeof(rec->hdr) ||
    713             rec->hdr.length > sizeof(*rec)) {
    714                 pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
    715                        rec->hdr.length);
    716                 return;
    717         }
    718 
    719         if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
    720                 pr_err(FW_WARN "CXL CPER invalid event\n");
    721                 return;
    722         }
    723 
--> 724         guard(rwsem_read)(&cxl_cper_rw_sem);

rwsem_read is a sleeping lock however there are several callers which
hold spinlocks or disable preemption.

    725         if (cper_callback)
    726                 cper_callback(event_type, rec);
    727 }

Here are the call trees that trigger the Smatch warning.

ghes_poll_func() <- disables preempt
ghes_irq_func() <- disables preempt
ghes_notify_hed() <- disables preempt
ghes_probe() <- disables preempt
-> ghes_proc()
   -> ghes_do_proc()
      -> cxl_cper_post_event()

Probe for example is holding spin_lock_irqsave(&ghes_notify_lock_irq, flags);

regards,
dan carpenter

