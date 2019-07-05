Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6D60857
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfGEOvM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 10:51:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:25617 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGEOvL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 10:51:11 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 07:51:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="185201897"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Jul 2019 07:51:07 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Jul 2019 17:51:06 +0300
Date:   Fri, 5 Jul 2019 17:51:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, raanan.avargil@intel.com
Subject: Re: [PATCH 7/8] thunderbolt: Add support for Intel Ice Lake
Message-ID: <20190705145106.GA2640@lahna.fi.intel.com>
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com>
 <20190705095800.43534-8-mika.westerberg@linux.intel.com>
 <CA+CmpXsak9Rvkq_RNzoxRecMercUPKqdK+KzbHv_fJC59inaHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXsak9Rvkq_RNzoxRecMercUPKqdK+KzbHv_fJC59inaHA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 05, 2019 at 05:44:01PM +0300, Yehezkel Bernat wrote:
> On Fri, Jul 5, 2019 at 12:58 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > +static void icm_icl_rtd3_veto(struct tb *tb, const struct icm_pkg_header *hdr)
> > +{
> > +       const struct icm_icl_event_rtd3_veto *pkg =
> > +               (const struct icm_icl_event_rtd3_veto *)hdr;
> > +       struct icm *icm = tb_priv(tb);
> > +
> > +       tb_dbg(tb, "ICM rtd3 veto=0x%08x\n", pkg->veto_reason);
> > +
> > +       if (pkg->veto_reason) {
> > +               if (!icm->veto) {
> > +                       icm->veto = true;
> > +                       /* Keep the domain powered while veto is in effect */
> > +                       pm_runtime_get(&tb->dev);
> > +               }
> > +       } else {
> > +               if (icm->veto) {
> > +                       icm->veto = false;
> > +                       /* Allow the domain suspend now */
> > +                       pm_runtime_mark_last_busy(&tb->dev);
> > +                       pm_runtime_put_autosuspend(&tb->dev);
> 
> Handling the removal of the veto is duplicated below. Worth introducing as a
> helper function?
> 
> > +               }
> > +       }
> > +}
> > +
> 
> ...
> 
> > @@ -1853,6 +1943,18 @@ static void icm_complete(struct tb *tb)
> >         if (tb->nhi->going_away)
> >                 return;
> >
> > +       /*
> > +        * If RTD3 was vetoed before we entered system suspend allow it
> > +        * again now before driver ready is sent. Firmware sends a new RTD3
> > +        * veto if it is still the case after we have sent it driver ready
> > +        * command.
> > +        */
> > +       if (icm->veto) {
> > +               icm->veto = false;
> > +               pm_runtime_mark_last_busy(&tb->dev);
> > +               pm_runtime_put_autosuspend(&tb->dev);
> > +       }
> > +
> 
> Here is the duplication.

Indeed, I'll put it to a helper function.

> > +static int nhi_suspend_power_down(struct tb *tb)
> > +{
> > +       int ret;
> > +
> > +       /*
> > +        * If there is no device connected we need to perform an additional
> > +        * handshake through LC mailbox and force power down before
> > +        * entering D3.
> > +        */
> > +       ret = device_for_each_child(&tb->root_switch->dev, NULL,
> > +                                   nhi_device_connected);
> > +       if (!ret) {
> > +               lc_mailbox_cmd(tb->nhi, LC_PREPARE_FOR_RESET);
> > +               ret = lc_mailbox_cmd_complete(tb->nhi,
> > +                                             LC_MAILBOX_TIMEOUT);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               return nhi_power_down(tb->nhi);
> 
> Just to be sure: unforce power is done only if no device is connected?
> My understanding of the comment above was that unforce power should be done
> anyway (so it should be outside of this if block), and the difference between
> the cases is only about the additional LC mailbox message. I guess I misread it.

nhi_power_down() should be only called if no device was connected so it
should be in correct place. I can try to clarify the comment a bit,
though.
