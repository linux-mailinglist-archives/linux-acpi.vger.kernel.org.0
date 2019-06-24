Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352625023F
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jun 2019 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFXG0F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jun 2019 02:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfFXG0F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 Jun 2019 02:26:05 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDE2E21530;
        Mon, 24 Jun 2019 06:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561357564;
        bh=k59t1m8wsiRmS1GXcPU6ssPkedRk7do9n0WBaDvykoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHnYZQ1c0qzeZe0amKkYEc5WHqmoV9zMD4AD/MVGJWW/TCq+qv2J8LVzfAm9erTKD
         cFaO4A7sv6a/0PTn+AfVwy/E814PajvGu1DtbW7ZtqVAB4V7M15vGyUdfFcc8lTI6x
         L4IFN0eSrxH8wZLP8iSXkdullBfO4wCD8cpy+hy0=
Date:   Mon, 24 Jun 2019 05:20:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 03/28] acpi: utils: Cleanup acpi_dev_match_cb
Message-ID: <20190624032007.GA23457@kroah.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
 <1560534863-15115-4-git-send-email-suzuki.poulose@arm.com>
 <CAJZ5v0j-AwFkeK35xG-WnDq8_wrzfH-0jqv6hVW+7uZD3R2k8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j-AwFkeK35xG-WnDq8_wrzfH-0jqv6hVW+7uZD3R2k8Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 18, 2019 at 12:08:45AM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 14, 2019 at 7:54 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
> > The prototype of bus_find_device() will be unified with that of
> > class_find_device() subsequently, but for this purpose the callback
> > functions passed to it need to take (const void *) as the second
> > argument.  Consequently, they cannot modify the memory pointed to by
> > that argument which currently is not the case for acpi_dev_match_cb().
> > However, acpi_dev_match_cb() really need not modify the "match" object
> > passed to it, because acpi_dev_get_first_match_dev() which uses it via
> > bus_find_device() can easily convert the result of bus_find_device()
> > into the pointer to return.
> >
> > For this reason, update acpi_dev_match_cb() to avoid the redundant
> > memory updates.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Or if you want me to take this patch, please let me know.

I'll take it now, thanks.

greg k-h
