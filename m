Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC5102995
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfKSQm1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 11:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfKSQm1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 11:42:27 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9DE22384;
        Tue, 19 Nov 2019 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574181746;
        bh=IoRuy5PlgBG8cHzzAaW1PMdYuuu78+gVQ8bvvtNy6g8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c1jHwxA4M+qLlTFeJkX+4ghY3WdnmlJelLLhKkt6XYMNtMFTCUmabd2beUN4Af9EZ
         rVRrgYcqJ9Njp7oRbGHshCIqcv1dFJ2IDHw41p0mkH9bI6/Y5NPSd88gBuNHDo1lLH
         U2TkpGfSmYpYNDvJxL3pgtymlUcQ01Y4lm77L3Sw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BAB153520F80; Tue, 19 Nov 2019 08:42:25 -0800 (PST)
Date:   Tue, 19 Nov 2019 08:42:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-next@vger.kernel.org
Subject: Re: next-20191118 rcutorture gets lots of "ACPI: Masking GPE 0x0"
Message-ID: <20191119164225.GA30878@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191119145146.GA25855@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119145146.GA25855@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 19, 2019 at 06:51:46AM -0800, Paul E. McKenney wrote:
> Hello!
> 
> I had occasion to run rcutorture on next-20191118, and in a five-minute
> run got 1,810,735 instances of "ACPI: Masking GPE 0x0" printed to the
> console.  This run is under qemu on an ordinary x86 laptop.
> 
> Is this a known issue?

Apparently it is, apologies for the noise:

https://lkml.org/lkml/2019/11/18/163

							Thanx, Paul
