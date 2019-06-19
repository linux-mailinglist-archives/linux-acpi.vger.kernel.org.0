Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A2E4B660
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2019 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfFSKoC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jun 2019 06:44:02 -0400
Received: from casper.infradead.org ([85.118.1.10]:45556 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfFSKoC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jun 2019 06:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WKW/0TRPIb29ZUwqdiEIWuQ61spuUdkZV5X/uIQH8S0=; b=t84WOhRQC7YxmEGug4+IeE6ZG2
        f+hoPyDbMpZ1t1RdL04ORAisWEtnBm7TBzZCei4viOpDDvy0Bz37Dzse0a6sB91zznwDqLFIavFPZ
        L2+aMBp0o3rBIpixd9Gbfy2CXTASqIiKw/0YX1jH4qmI2yIxEVvhclGLgH9oz2oQfnMjq5r3Ma7FH
        VPBesNLK0jlZm/X+Azr5T27AVvWUO6/aNwXoUAVTdV9RvkWs8SrgtucdWogeS+Xl0RSaxeOX7X+4Y
        bTSgdODUhdMY6pcuFbSLEtjyuA2CUsklO6h4/EoWuCbjvgnNaiwS5whTX9PyKRUDIjnU/OmVMIVdt
        t6pOk19w==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdY4M-0003f9-Vr; Wed, 19 Jun 2019 10:43:59 +0000
Date:   Wed, 19 Jun 2019 07:43:52 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 20/22] docs: extcon: move it to acpi dir and convert
 it to ReST
Message-ID: <20190619074352.79993138@coco.lan>
In-Reply-To: <4701210.Ilfu9VLqBR@kreacher>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
        <b6d199c3e7c8c868acbb313a1a516ea8aed042ee.1560891322.git.mchehab+samsung@kernel.org>
        <4701210.Ilfu9VLqBR@kreacher>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Em Wed, 19 Jun 2019 11:59:18 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> escreveu:

> On Tuesday, June 18, 2019 11:05:44 PM CEST Mauro Carvalho Chehab wrote:
> > The intel-int3496.txt file is a documentation for an ACPI driver.
> > 
> > There's no reason to keep it on a separate directory.
> > 
> > So, instead of keeping it on some random location, move it
> > to a sub-directory inside the ACPI documentation dir.
> > 
> > For now, keep it with .txt extension, in order to avoid
> > Sphinx build noise. A later patch should change it to .rst
> > and movin it to be together with other acpi docs.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Or please let me know if you want me to pick up this one.

Feel free to pick it.


Thanks,
Mauro
