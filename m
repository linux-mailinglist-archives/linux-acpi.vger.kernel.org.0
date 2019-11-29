Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F510DAAC
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 21:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfK2UxZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 15:53:25 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:56040 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfK2UxY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Nov 2019 15:53:24 -0500
X-Greylist: delayed 1049 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 15:53:23 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 47PmVh4lT3zDlm
        for <linux-acpi@vger.kernel.org>; Fri, 29 Nov 2019 15:35:56 -0500 (EST)
Received: from hp-x360n (rrcs-98-153-158-222.west.biz.rr.com [98.153.158.222])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47PmVd1m2pzm6L;
        Fri, 29 Nov 2019 15:35:53 -0500 (EST)
Date:   Fri, 29 Nov 2019 12:35:51 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] ACPI: PM: s2idle: Fix possible suspend lock-up
In-Reply-To: <2787005.CsmIKtZlk9@kreacher>
Message-ID: <alpine.DEB.2.21.1911291231510.6038@hp-x360n>
References: <2787005.CsmIKtZlk9@kreacher>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On Thu, 28 Nov 2019, Rafael J. Wysocki wrote:

> Please test this series and let me know if it works for you too.

I've tested this quite a few times against the issues reported on the Linux-PM
mailing list ("resume failures if the charger is plugged in while suspended
and the battery is at < 90%" and "spurious wakeups from the EC for non-power
events") and this patchset has fixed both of these issues (the latter is
especially surprising and welcome).

I'm pretty happy with it; it's been a while since I've had a consistently
cold laptop while suspended. Much thanks!

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
