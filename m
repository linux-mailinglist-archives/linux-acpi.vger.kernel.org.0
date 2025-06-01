Return-Path: <linux-acpi+bounces-14043-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C120AC9EDC
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Jun 2025 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9D1188DF06
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Jun 2025 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6318DB1D;
	Sun,  1 Jun 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="b7IR2FiI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB74437C
	for <linux-acpi@vger.kernel.org>; Sun,  1 Jun 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748787827; cv=none; b=tuoN3BLMiUFXTEaIYCI+LHpSl2MCJ5krzGMRD4rYbNRhRP+MV1tDk6HJD1cPVGCDjv48K6XLRoiF+wQd8P2s5Yqrrw/dDt4VCh3P1TIqlURiAQlJu2ziZKzk7Q4JKMgOCHJ6WfyV6BcEgswKnjUtcubygWOPFkha0e9LuK6rqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748787827; c=relaxed/simple;
	bh=QPFwFiDNeaFTW/ChjiUJY6t3Mpgyd+/uyJeElBr8e0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7SeKa98H95atclu/HKpKIonXEcDv5LcbPGuPBzC1SmXcAb2zYk7h9O/J+SyNDsqq6ZH6pmVnKhA5czf3Q4V7+pg+WfiAOQeuRbDZ1IT6F0GUMP3cD6I5yolNUuj2+e7uSIwijS54eX3AoA2Hr1FBxfc1EaH2QWNzKVWIEkQdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=b7IR2FiI reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ntBn5HB9KIKPCtMmBAu0MCGnMuUrciX6HHTacvrxTyA=; b=b7IR2FiIMV4sREK9WRMsGF3pLJ
	XVXCyKsgUANkjTCt2naoGkKeIj6P4D9lGRwU1ZBNRFOq9JAhH/fLWDcpGbLMlHq0thrW4lUbtiN52
	OQgDbmXsBAjjdUATvAtqNN9yKNKTxk+R5gQiH+0MC2wwDbMZducthNYac8WgsO3OqqeoxQHDsuHw3
	2Q7nYPpr6st9Bky1IVg6j1EKbWSdsctAz3mesW6e6VkgX16TWbdhz+masZJmHnEFI02BYpG8Svm/J
	dCLVX2MhINYwBLHoX6Fk9zvoU2Vs7XeyKQH5WMWbyHZmMuEfWtIzJxcUZvgq7BAhe1bx3Px6E3C/c
	v19IO0SA==;
Received: from c-24-4-65-180.hsd1.ca.comcast.net ([24.4.65.180]:52690 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1uLi5X-0007KG-WA by authid <merlins.org> with srv_auth_plain; Sun, 01 Jun 2025 07:23:28 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1uLjay-003Pzp-08;
	Sun, 01 Jun 2025 07:23:28 -0700
Date: Sun, 1 Jun 2025 07:23:28 -0700
From: Marc MERLIN <marc@merlins.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-acpi@vger.kernel.org
Subject: Re: s2idle on kdell xps 9730 does go to sleep but laptop is warm
Message-ID: <aDxiYDc-pOVY-p3t@merlins.org>
References: <aCWbk4z50QYym9gV@merlins.org>
 <aDt0CH4zO96pxdIu@merlins.org>
 <20250531231626.GB179983@mit.edu>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531231626.GB179983@mit.edu>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.4.65.180
X-SA-Exim-Mail-From: marc@merlins.org

On Sat, May 31, 2025 at 07:16:26PM -0400, Theodore Ts'o wrote:
> On Sat, May 31, 2025 at 02:26:32PM -0700, Marc MERLIN wrote:
> > This is still a problem. Is there more info I can provide? For now it's
> > bad enough that I can't have the battery be in S3 sleep for 24H without
> > the batteries running out :-/
> 
> I believe what is going on is that on more modern systems, it relies
> on the OS's drivers to power done various peripherals (e.g., graphics,
> SSD's, etc.) and this is no longer being done by the low-level
> firmware.  With Linux the CPU is put to sleep, but there's a lot more
> on a modern mainboard than just the CPU....

Hi Ted, nice to hear from you.  Yes, I agree that what you wrote totally
matches my experience and the reason why the laptop was so warm, even in
sleep mode.

So, given that this is not a new problem, are there any new options in
linux drivers and/or kernel options to have linux do this (shut down
each subsystem)?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

