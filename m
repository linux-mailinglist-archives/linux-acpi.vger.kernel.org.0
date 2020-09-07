Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A425FBD9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgIGOLB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 10:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgIGOKt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 10:10:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5636E2064B;
        Mon,  7 Sep 2020 14:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599487843;
        bh=e1NrzKX/AI7LNPipSNQp264/D1Za/ZcFt4pINAUa0do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Udt4MW4UsgJoY7imOEBnwxqYY0gF8VODhcPuSlcjDtAISEexshh/MiVm+5sK3yWdv
         jNBX6T92ly1GE+eE4yxx1zTZJUW+/oCs8DRD0o58iu2LKbxP6cL2re0vqLcMLlWUAd
         ghoJdeB1o3mpNRqhdAt30vdbMKoKMRdbJ62s3dFk=
Date:   Mon, 7 Sep 2020 16:10:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        linux-acpi@vger.kernel.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: Re: [PATCH 2/2] usb: typec: intel_pmc_mux: Do not configure SBU and
 HSL Orientation in Alternate modes
Message-ID: <20200907141058.GA3720524@kroah.com>
References: <20200907135740.19941-1-heikki.krogerus@linux.intel.com>
 <20200907135740.19941-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907135740.19941-3-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 04:57:40PM +0300, Heikki Krogerus wrote:
> From: Utkarsh Patel <utkarsh.h.patel@intel.com>
> 
> According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> 0.7, bits 4 and 5 are reserved in Alternate modes.
> SBU Orientation and HSL Orientation needs to be configured only during
> initial cable detection in USB connect flow based on device property of
> "sbu-orientation" and "hsl-orientation".
> Configuring these reserved bits in the Alternate modes may result in delay
> in display link training or some unexpected behaviour.
> So do not configure them while issuing Alternate Mode requests.
> 
> Fixes: ff4a30d5e243 ("usb: typec: mux: intel_pmc_mux: Support for static SBU/HSL orientation")
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Shouldn't this also need a cc:stable?

And why not cc: the linux-usb list on these patches?

thanks,

greg k-h
