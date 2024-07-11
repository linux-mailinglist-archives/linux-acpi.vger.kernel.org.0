Return-Path: <linux-acpi+bounces-6864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092DD92F051
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 22:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B808728382F
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2024 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731E613D626;
	Thu, 11 Jul 2024 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYI7twYS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eozyysvx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7751004;
	Thu, 11 Jul 2024 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729945; cv=none; b=ctgboncvRS4WVKY+w0EGlQrF03wgjlsFobIX5Y816BZD5A6DS6nawFjv5KUFcS+JyK/c2SNU4Ot06t6u1eD+bC+btk4Q0KO07eb/NrLhRn58qCB7783zmgEyCfcR5/hrfMYnSeTK0THSBZYgzS0kd8zJrK1wAZyjAZg4AiWIVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729945; c=relaxed/simple;
	bh=DVUra7e6MiJ9K709Q7LckMZjZdMsEgUqxtsJ+GklD6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQH2DhK1s0E1omlfW4DRhLrjhNNMuANhRjQCrj9OZ6uSv78n5E+Id9SdH9KrJtGg+8ucMMm7hCfaSqY/o0Tb8po8EsXj3PhwV9JpoxmL031H2WsCP3IzZXl00vvZFU9ToczUbLgf2Ptj6Vu2eZ6gGKlUt8tYIGd0RMJVR+fbwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYI7twYS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eozyysvx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720729942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZMjCRDqkz7b+klfdvCcAfVnksBty1HBVIGMIEucNdQ=;
	b=DYI7twYST48K96/FHtARtvi+zDISF+X6DqfYliZezoAD0AKg0Epff8brPqOihgTREQB+Lp
	o1uJrUTiLu3S+xItwrSUdWmA4yaMMtEQx2N4RuYf+03pt25I698tTgONg0v+T2tErJVt5k
	I62MTOpg21c8dfX9KwGEFZJoOuCgFPwuIuCKuN8H9prnRj3IisOZur01ostaByH7fPHZwH
	zRkVkFH814SpYF3q9x0kthZQp9aIYgHF+TCvIMg5yAZlXkDO31D3RCK242nEsiCccH6Aba
	5FXdVy+bZGA23BL33ljSYWdMUUK+/9eVaMFUkkhPbKS2xnd16VMwxm/wZvF2XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720729942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZMjCRDqkz7b+klfdvCcAfVnksBty1HBVIGMIEucNdQ=;
	b=eozyysvxa5I+qHMppDs4wqGGafob7UqDvZYxnstcKjgHnTvK4iTE36px5RCQxlnAW4VHAF
	jr7bm7YDlgXDVVAg==
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI
 <linux-acpi@vger.kernel.org>, Stefan Seyfried
 <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH v1] irq: Set IRQF_COND_ONESHOT in request_irq()
In-Reply-To: <5800834.DvuYhMxLoT@rjwysocki.net>
References: <5800834.DvuYhMxLoT@rjwysocki.net>
Date: Thu, 11 Jul 2024 22:32:21 +0200
Message-ID: <877cdru0tm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 11 2024 at 12:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The callers of request_irq() don't care about IRQF_ONESHOT because they
> don't provide threaded handlers, but if they happen to share the IRQ
> with the ACPI SCI, which has a threaded handler and sets IRQF_ONESHOT,
> request_irq() will fail for them due to a flags mismatch.
>
> Address this by making request_irq() add IRQF_COND_ONESHOT to the flags
> passed to request_threaded_irq() for all of its callers.

In principle that should work. We'll see whether there are dragons
lurking :)

Thanks,

        tglx

