Return-Path: <linux-acpi+bounces-17076-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A089DB8128F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 19:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E10323C1C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856D2FD7DF;
	Wed, 17 Sep 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAYR6UOj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DF2FD7B3;
	Wed, 17 Sep 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129835; cv=none; b=Qlq+GxzwTnFd773g9HTN59LofBeaaGjdcJM1UHAzeGjgLmXmomv+bePKdjDJtLn8gTP0+lfV9+whgwlouasI8m1Eyv9Cp3UPH0To0SvvbMUIZIOySA90dUD6lQxGsWShKYIUqPH7SkwUKdviWz/UNRNNDpzH7mPDNiXd+7Lt9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129835; c=relaxed/simple;
	bh=AEjr09QcVFyHfR49Xhj+cZndmHLQP2q4JTzun26NeA8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QU0Qno7oMxiKl9HhAAuAJtWNewSBYsgcE5BpP4mbcYDv7lbL3V66GYcMOFRw8r9UtE1GWRuMP0X439imIM7HrYgIFzH56kHXpfRVXcmLhc4/ihrQKTrezT+NLBbZ03gm5JKbegxpjhynNhwA4NDPBPhbKLqUg0zKzRc5B79/4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAYR6UOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19270C4CEFB;
	Wed, 17 Sep 2025 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758129835;
	bh=AEjr09QcVFyHfR49Xhj+cZndmHLQP2q4JTzun26NeA8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=MAYR6UOjLdo7DFEoGecQvOTeLMCCGup/8ZTPEXVpmzeBHhQM43nAUhEnWIeZ47kdk
	 KmSVPmwpAFZb91dKZs/QxIA6APe9JVMcY8R+FLwqPnckkz7aaD0VGuh4gTfHO3OJbs
	 plKq6+H7mH6Mr/+NdJ3DlWdZRHTDfBxFgXrzRWMeJCrandLTNOqXHWhPpd3MaIBDwR
	 R+HSVON1gLASAjLIHfF9X1m1gaYU8pC+TC6kPJkjlXZHoCpyLLkDZfof0Rg8efdx/A
	 7QYnZEy2gkNaRUl//5T+WXfwKhwd7wKxG+c6cZs8nSg4wa0vpfhTlpMQZK23c8M4uk
	 YTiRT0GUz9thw==
Date: Wed, 17 Sep 2025 11:23:49 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, hchauhan@ventanamicro.com
cc: xueshuai@linux.alibaba.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-acpi@vger.kernel.org, james.morse@arm.com, tony.luck@intel.com, 
    cleger@rivosinc.com
Subject: Re: [RFC PATCH 1/5] riscv: Define ioremap_cache for RISC-V
In-Reply-To: <20250910093347.75822-2-tianruidong@linux.alibaba.com>
Message-ID: <f15b08a6-84f5-1e5c-79cd-a178037a2f11@kernel.org>
References: <20250910093347.75822-1-tianruidong@linux.alibaba.com> <20250910093347.75822-2-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Sep 2025, Ruidong Tian wrote:

> From: Himanshu Chauhan <hchauhan@ventanamicro.com>
> 
> bert and einj drivers use ioremap_cache for mapping entries
> but ioremap_cache is not defined for RISC-V.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>

Looks like nothing should be using ioremap_cache() at all:

  https://lore.kernel.org/linux-riscv/YzQ6pqykLhJVeD2p@infradead.org/#t

Probably best just to fix the ACPI drivers?


- Paul


