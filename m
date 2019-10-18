Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25EDCAC5
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 18:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394510AbfJRQQp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 12:16:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43070 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfJRQQp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 12:16:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id o44so5421869ota.10
        for <linux-acpi@vger.kernel.org>; Fri, 18 Oct 2019 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yvne9gR5NX8diVvQ4owtsBgM2mX2Xb63EAQlH8HuKk=;
        b=pgtBz1yNdYHNJjI2qaamNbVambOK9yJQgeULnvuFlYsPJ9Rjw1N2d9H+8UMr9eWj3b
         9liGZz4th/SqPt1msrv5ZhJ9X9azJiH5HNasIcgScD598JWlRWnzuFGS5AXysqgA6HLk
         gwKe5zRem+TLue5OOjkQh/IQhuxj1AIg1HfVEcb//hOpoKtgw5H/2dP9kiqZLYOx1QBF
         SrL6WQzrY22NyTxaL8lcVppjuosDDGcqNgrGBBEmn5Oh8WYlAZ4hC7itFji5GF+ZbDMS
         QAID4k1OHaUbZNUNfqTZiKItV2l49Gld9cwb/kfcjD69FsTkXtRptAEHg/UKD/mgPmFj
         rfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yvne9gR5NX8diVvQ4owtsBgM2mX2Xb63EAQlH8HuKk=;
        b=NT3cW4UFbCxfz74GZ4LRqQQQjVlcaHiSloLUpw4Yf/D/we/bNRNbCXLWZHKctp1KEx
         b0WU4JUpGf5F2XLtGTl7z4zSw04zWZKbN+PGXCRPFEOV6BAJknIPd7ZLvUkbs05MBoeu
         IieG3ZovgsItvoWgq1ODqVdkQ1Kxhd6VTY/ZKnpEuabIeN8A+GpSHdIklasqHnRMzn0e
         ek1RXZBoJNhM4gUFRWE2pc1V+x43KzcRD1ptdTZ3yMW71qwzri5aSUrwGcof6gABR2oi
         qU7b+0csUBb9wKDid9l4auuq3c5CiQJ4wkbu8zwaQ/Rcb/r3wvk1sq8fOC7bktMVIIkK
         E5Dg==
X-Gm-Message-State: APjAAAVqEk1P+Ndhc6hBJDfi/Q7ZgrepuSLbP2BUGqLTzCy5ScRudG7p
        n2Yi+ql96/bGYOYhJ0FVovojjobr/HS7bWtX7qZOPg==
X-Google-Smtp-Source: APXvYqyblv3J/xJHeQdDv4C30Sjo0Fd3shSE2mry0JpF/Y+67xf+0kg0irQ3y+5bIupfWe2BJ5cEte7rGplRl+cUL8w=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr8454155otn.363.1571415404227;
 Fri, 18 Oct 2019 09:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191018123534.GA6549@mwanda>
In-Reply-To: <20191018123534.GA6549@mwanda>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Oct 2019 09:16:33 -0700
Message-ID: <CAPcyv4jm7kiayfHnBcm7mNW2NeJ81LeUVphMYG0Tq50is-tQ0A@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: unlock on error in scrub_show()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2019 at 5:37 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We change the locking in this function and forgot to update this error
> path so we are accidentally still holding the "dev->lockdep_mutex".
>
> Fixes: 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good to me, thanks Dan.
