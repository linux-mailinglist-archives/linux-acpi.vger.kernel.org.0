Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1021A3F1
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGIPoE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 11:44:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42384 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIPoE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2020 11:44:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id g37so1994678otb.9;
        Thu, 09 Jul 2020 08:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Sym5KQVj8VqaMlSDW0Jc0j+Tk3pFvysmGFqfcg2Rvs=;
        b=oWOn4R78xsxEibGz6deMujXww252NtLv0VBrjgaSpDo/xjC4TCDjgm2dcsNS3WCQ1P
         Zj/29agFt3vjOxviDPacHioHRYXNY7Qtqqj+HXR34htRBQm2Fkuv65LrvT5kAkHadOsl
         1IF1IzIZInVRV2NgX8CJ4LWsFaNDVQgAcoDE26aK9NMbYQST+dohQQR+SFHkpixwzKJt
         //I/U2F+pFa8L6zgwsBsXy+4uKAlOwcG7hj8oSGEDnjb1Z6AxQ9GSYJbdz5YdrviVb98
         xk3yd3yvIUYJJncYUVH7tYA9rKyIog4Eu0T/i2o13EW01ApjtxIBQGRRPZtG2wYZiXmE
         6tDA==
X-Gm-Message-State: AOAM531pu32WD9yL7Uk3bxP5OdDZFHPTqt1/FNQwEg/hGNi9jliw6LH6
        RDicyP266Y2MnyJFZ+5J8MHkzuE5V1hlvqGzlJI=
X-Google-Smtp-Source: ABdhPJyl5cUpGVf4J6oVAx/ugmkS7qnUi0jZS8XkXNGXgHJrgdpNOsltf7QnMuVARuoppuhb/s8y3Fa214SXcCONguY=
X-Received: by 2002:a9d:1c82:: with SMTP id l2mr36010851ota.167.1594309443612;
 Thu, 09 Jul 2020 08:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200709150051.GA17342@infradead.org> <20200709153854.GY23821@mellanox.com>
In-Reply-To: <20200709153854.GY23821@mellanox.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jul 2020 17:43:52 +0200
Message-ID: <CAJZ5v0hW79nEe1P5YqNx0o0jHAMuPw-i02GY3TCvG_uFu48ETg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 9, 2020 at 5:39 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jul 09, 2020 at 04:00:51PM +0100, Christoph Hellwig wrote:
> > On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> > > The runtime firmware activation capability of Intel NVDIMM devices
> > > requires memory transactions to be disabled for 100s of microseconds.
> > > This timeout is large enough to cause in-flight DMA to fail and other
> > > application detectable timeouts. Arrange for firmware activation to be
> > > executed while the system is "quiesced", all processes and device-DMA
> > > frozen.
> > >
> > > It is already required that invoking device ->freeze() callbacks is
> > > sufficient to cease DMA. A device that continues memory writes outside
> > > of user-direction violates expectations of the PM core to be to
> > > establish a coherent hibernation image.
> > >
> > > That said, RDMA devices are an example of a device that access memory
> > > outside of user process direction.
>
> Are you saying freeze doesn't work for some RDMA drivers? That would
> be a driver bug, I think.
>
> The consequences of doing freeze are pretty serious, but it should
> still stop DMA.

Yes, it should.  The "freeze" callbacks are expected to prevent any
DMA transfers from being carried out after they have been executed.

Thanks!
