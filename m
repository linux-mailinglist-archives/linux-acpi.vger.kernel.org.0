Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972C131CFF0
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBPSM5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 13:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBPSM4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 13:12:56 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D58C061574;
        Tue, 16 Feb 2021 10:12:16 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lC4pR-00Egds-Ey; Tue, 16 Feb 2021 18:12:05 +0000
Date:   Tue, 16 Feb 2021 18:12:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <YCwK9SblYCh/1lZS@zeniv-ca.linux.org.uk>
References: <20210216014538.268106-1-ben.widawsky@intel.com>
 <20210216014538.268106-5-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216014538.268106-5-ben.widawsky@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 15, 2021 at 05:45:33PM -0800, Ben Widawsky wrote:
> +	if (cmd->info.size_in) {
> +		mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
> +		if (!mbox_cmd.payload_in) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +
> +		if (copy_from_user(mbox_cmd.payload_in,
> +				   u64_to_user_ptr(in_payload),
> +				   cmd->info.size_in)) {
> +			rc = -EFAULT;
> +			goto out;
> +		}

Umm...  Do you need to open-code vmemdup_user()?  The only difference is
GFP_KERNEL allocation instead of GFP_USER one, and the latter is arguably
saner here...  Zeroing is definitely pointless - you either overwrite
the entire buffer with copy_from_user(), or you fail and free the damn
thing.
