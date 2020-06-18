Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E41FEDBC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jun 2020 10:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgFRIg6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jun 2020 04:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFRIgy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Jun 2020 04:36:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE5F214DB;
        Thu, 18 Jun 2020 08:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592469413;
        bh=ceL/T8t0nvr/U3tOjodwMKknS/aAxNJ8RojCHrLF1ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fhmVqgBm4oYl3kaigyXF+fjYbAtWBnSCDQ01zfS0JLYK3gukCSKFX5/7FuhT1Rddg
         G+/nRvmR+h/ih67DEse6ah3ZJOIHmQNa/IrfpIzNqOgVLauwcJ4gL8gLuByIeLnTZe
         XbWo06NX2QYRQYvzI3OU8jnZRnrWl3CjgdK+X07A=
Date:   Thu, 18 Jun 2020 10:36:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200618083646.GA1066967@kroah.com>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
 <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
 <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc6eA33cyAQH-m+yixTuHqiobg6fo7nzbbb-J6vN6qFcA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 18, 2020 at 11:12:56AM +0300, Andy Shevchenko wrote:
> On Wed, Jun 17, 2020 at 10:56 PM Rajat Jain <rajatja@google.com> wrote:
> > On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> 
> ...
> 
> > (and likely call it "external" instead of "untrusted".
> 
> Which is not okay. 'External' to what? 'untrusted' has been carefully
> chosen by the meaning of it.
> What external does mean for M.2. WWAN card in my laptop? It's in ACPI
> tables, but I can replace it.

Then your ACPI tables should show this, there is an attribute for it,
right?

> This is only one example. Or if firmware of some device is altered,
> and it's internal (whatever it means) is it trusted or not?

That is what people are using policy for today, if you object to this,
please bring it up to those developers :)

> So, please leave it as is (I mean name).

firmware today exports this attribute, why do you not want userspace to
also know it?

Trust is different, yes, don't get the two mixed up please.  That should
be a different sysfs attribute for obvious reasons.

thanks,

greg k-h
