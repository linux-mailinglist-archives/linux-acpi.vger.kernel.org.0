Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2125FBE3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgIGONt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 10:13:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:27183 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbgIGONO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Sep 2020 10:13:14 -0400
IronPort-SDR: vbThgL9trhFKBS9ucnfEDLf3cNJOZ+dm75fxZ/vj/aoTQ7IA7Ht1w0MHdB/DR4gpU2sh7tExcd
 tK8PrOCI7/jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="222216930"
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="222216930"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 07:12:52 -0700
IronPort-SDR: Y8ga9bAqC9who7nQKisU4aQ3ovnCNTZHcXKpaeG8SCpE9/Ho17vrDh38/UNja6fHrpem4LXRY0
 7lGLIdNincsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,402,1592895600"; 
   d="scan'208";a="406848879"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Sep 2020 07:12:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 07 Sep 2020 17:12:46 +0300
Date:   Mon, 7 Sep 2020 17:12:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        linux-acpi@vger.kernel.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: Re: [PATCH 0/2] Fixes for the Intel PMC mux driver
Message-ID: <20200907141246.GB3101050@kuha.fi.intel.com>
References: <20200907135740.19941-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907135740.19941-1-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 07, 2020 at 04:57:38PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> Here are two of fixes from Utkarsh. Both deal with alternate mode
> issues. Let me know if you want anything to be changed.
> 
> thanks,
> 
> Utkarsh Patel (2):
>   usb: typec: intel_pmc_mux: Do not configure Altmode HPD High
>   usb: typec: intel_pmc_mux: Do not configure SBU and HSL Orientation in
>     Alternate modes
> 
>  drivers/usb/typec/mux/intel_pmc_mux.c | 12 ------------
>  1 file changed, 12 deletions(-)

Wrong mailing list :-/

I'll resend these to the correct usb mailing list.

-- 
heikki
