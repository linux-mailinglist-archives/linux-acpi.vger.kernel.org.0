Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8B6108F
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2019 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfGFLnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Jul 2019 07:43:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43394 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfGFLnN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Jul 2019 07:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h4V3ZBI0FoiW9U4A7MoCEA3P8Nxtu03FgBYGvwN2wds=; b=dZWNuWG7t17scVwtDp0hcELzP
        7FuWeX0o1hkpcP8DTnZBpv6YgADHytOoYFCbz5md5XR9RmiXkUI4P+Ur1+qi3wFffcM5UQMx0UZG7
        zZ0IK5/xT9VlTU8+3hBxHv7AXatlkDMxvIFy25hDjxYn9z+AIDXp0Uhl3iOIEk7gdiHqneLCYhF3q
        5NPHERrSRvyvWG0EtDfVqWp6EGbshR6kyMgzZfMNkNHfK5VjfEREeDJg5Gvb62k1knnCwhuqXUAF+
        8mfU036WJ8o369L4yDJ5h6OBCT7Q9krOnXb+u+02wq5SpvFTqYhGmdc39Amo4PdvibPDujGEI6w5U
        OmnRQnm+g==;
Received: from 177.205.70.5.dynamic.adsl.gvt.net.br ([177.205.70.5] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjj5y-0000yv-Uf; Sat, 06 Jul 2019 11:43:11 +0000
Date:   Sat, 6 Jul 2019 08:43:05 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 39/39] docs: gpio: add sysfs interface to the
 admin-guide
Message-ID: <20190706084305.010f2d77@coco.lan>
In-Reply-To: <CACRpkdbBA612W0x6Y-dwe3E4dhH2ospmn+m2YJ8Sh_Um6XGYhA@mail.gmail.com>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
        <1ecff14ec37c0c434f003d93c4b86b1cd3dac834.1561724493.git.mchehab+samsung@kernel.org>
        <CACRpkdbBA612W0x6Y-dwe3E4dhH2ospmn+m2YJ8Sh_Um6XGYhA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Em Wed, 3 Jul 2019 10:44:38 +0200
Linus Walleij <linus.walleij@linaro.org> escreveu:

> On Fri, Jun 28, 2019 at 2:30 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> 
> > While this is stated as obsoleted, the sysfs interface described
> > there is still valid, and belongs to the admin-guide.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> This doesn't apply to my tree because of dependencies in the
> index 

Yeah, this /39 patch series heavily touch the index files.
Better to merge them altogether.

> so I guess it's best if you merge it:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Mauro

> 
> Yours,
> Linus Walleij



Thanks,
Mauro
