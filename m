Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A031167B3
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2019 08:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLIHzU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Dec 2019 02:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfLIHzU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Dec 2019 02:55:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC1B206D3;
        Mon,  9 Dec 2019 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575878119;
        bh=DaR45PysoJXHMaxRkOP8gAHnT0qEyfHeF19TX2z6c/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yft/v87fq5MWL/mCAs04lb5IOTkRoex4mR1XamJao0XXW4hnz6AW8w/BVQkqaWmUO
         hD/R/DRh0xoSucGdN47qKOc3gxYF1QXX0OYMoo3cUtXH9nvHfco46xkcef23aOWBJi
         lv1BC+4owpB6Gg+JyrYm3zlDj+QJCzX5J/iQKvaE=
Date:   Mon, 9 Dec 2019 08:55:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tao Xu <tao3.xu@intel.com>
Cc:     rafael.j.wysocki@intel.com, lenb@kernel.org, keith.busch@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/HMAT: Fix the parsing of Cache Associativity and
 Write Policy
Message-ID: <20191209075517.GA691602@kroah.com>
References: <20191202070348.32148-1-tao3.xu@intel.com>
 <5cb15538-7097-1aa1-00a1-ce21c086c13b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb15538-7097-1aa1-00a1-ce21c086c13b@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 09, 2019 at 03:43:21PM +0800, Tao Xu wrote:
> Gentle ping :)
> 
> On 12/2/2019 3:03 PM, Tao Xu wrote:
> > In chapter 5.2.27.5, Table 5-147: Field "Cache Attributes" of
> > ACPI 6.3 spec: 0 is "None", 1 is "Direct Mapped", 2 is "Complex Cache
> > Indexing" for Cache Associativity; 0 is "None", 1 is "Write Back",
> > 2 is "Write Through" for Write Policy.
> > 
> > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> > ---
> >   drivers/acpi/numa/hmat.c | 4 ++--
> >   include/linux/node.h     | 4 ++--
> >   2 files changed, 4 insertions(+), 4 deletions(-)

It was the middle of the merge window that just ended a few hours ago.
Please give maintainers a chance to catch up...

