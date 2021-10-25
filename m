Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA111438FBE
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJYGvK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 02:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhJYGvJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 02:51:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F6A160EDF;
        Mon, 25 Oct 2021 06:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635144528;
        bh=naf7hWhE/j/sObnyo0YE4YDWprqI9hw0xmLfesaqTQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8Urci4zNJ5AEGIwFPGxzyjyfkzWoBnY0Qzzk1WvWQVrs85lo2bajXMjfbxXtrOth
         WpkQjI+BzL+pqE5Xi6M3sgiNzZ1mQT6RAVCYKignmrKcz1nXkUldXU1xl0rNFukIMp
         6Ehj2hyCgRYIqdfhNRTdk9pCtL4tuoi0x+KFa9pU=
Date:   Mon, 25 Oct 2021 08:48:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <YXZTTQLRC/4SQFl+@kroah.com>
References: <cover.1635140590.git.yu.c.chen@intel.com>
 <e6f876d0c8a3198e333228327fb46e0c716fc0c3.1635140590.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f876d0c8a3198e333228327fb46e0c716fc0c3.1635140590.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 25, 2021 at 02:25:27PM +0800, Chen Yu wrote:
> Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> (Root of Trust), which allows PFRU handler and other PFRU drivers to
> produce telemetry data to upper layer OS consumer at runtime.
> 
> The linux provides interfaces for the user to query the parameters of
> telemetry data, and the user could read out the telemetry data
> accordingly.
> 
> The corresponding userspace tool and man page will be introduced at
> tools/power/acpi/pfru.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

The review comments I made on the previous patch in this series also
apply here.

thanks,

greg k-h
