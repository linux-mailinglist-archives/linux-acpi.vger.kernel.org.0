Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29726102759
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 15:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKSOvr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 09:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfKSOvr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 09:51:47 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5D721852;
        Tue, 19 Nov 2019 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574175106;
        bh=JuzqTd3NVeckvX68vB9Lxu/bRIc4Olqag4QvHFImYVo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=mHiheVcRly3VX80J1Cqm9k2B/42WIDiK9T3r8z7+tojpjvlOZ/q4mOIcxC1Lm1Tc3
         GFsBmU13ZO+4VCcui703f02pFL74SVg52FVlOnBTIEjprMl4GyIcgl0j9xOsXa43OQ
         LS7yf2ltwBIRLyyyfjqp3x+PZFYX3tF2nuwAOP8k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 895D23520B06; Tue, 19 Nov 2019 06:51:46 -0800 (PST)
Date:   Tue, 19 Nov 2019 06:51:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-next@vger.kernel.org
Subject: next-20191118 rcutorture gets lots of "ACPI: Masking GPE 0x0"
Message-ID: <20191119145146.GA25855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello!

I had occasion to run rcutorture on next-20191118, and in a five-minute
run got 1,810,735 instances of "ACPI: Masking GPE 0x0" printed to the
console.  This run is under qemu on an ordinary x86 laptop.

Is this a known issue?

							Thanx, Paul
