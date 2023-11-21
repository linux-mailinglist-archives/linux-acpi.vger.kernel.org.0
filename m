Return-Path: <linux-acpi+bounces-1646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01917F25BE
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 07:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34AE1C2145D
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613482D602
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Nov 2023 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2zhSnz7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B605F9
	for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 21:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700545735; x=1732081735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JwKUvCe4kQ8RzH5NcY2TxXZi8FdLTy3xoBa5e7IPXxE=;
  b=X2zhSnz7xJWB+EvL4iYDMM6jFm77lxNCtAqFrgawdKMfX8FSKxSjzIpx
   CBkPxGraOpm6OWJGYAGvf+aFTgxZD3O+LrewJ+RE4zX8S+RufMweMrsBd
   TZUKf+r3AtT1HutpsSFD8a435Nm2+W6UGj+RA2cj0KX9t7MOMKhrnLQet
   CynzdnS+lDcwvCTrM0T1GZXa1OjkvESsJHyy2rjUavQ3O3dGhju1VwQUQ
   SuenKc6G0D4Sa4eydBEk5pP3Faqt1uIAYn2OjQquVtFnCUGmVDSoO3MRk
   iXuuRxlTghDWH0vVlBEhN7Fgg9mrYnr6368ALPjvhX5IgKPCFRvMyFRsx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="13317206"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="13317206"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:48:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="742933760"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="742933760"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 20 Nov 2023 21:48:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id ED7AA13A; Tue, 21 Nov 2023 07:48:51 +0200 (EET)
Date: Tue, 21 Nov 2023 07:48:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, NaamaX Shachar <naamax.shachar@intel.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI: Run USB4 _OSC() first with query bit set
Message-ID: <20231121054851.GC1074920@black.fi.intel.com>
References: <20231114120611.128054-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0iEt=GqEkVPp5iuBzKjKGxq9i7=W_L+NiOBk4oGiwyHdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iEt=GqEkVPp5iuBzKjKGxq9i7=W_L+NiOBk4oGiwyHdg@mail.gmail.com>

On Mon, Nov 20, 2023 at 05:54:28PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 14, 2023 at 1:06 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > The platform can deny certain tunneling from the OS and it does that by
> > clearing the control bits it does not want the OS to get and returning
> > with OSC_CAPABILITIES_MASK_ERROR bit set. Currently we do not handle
> > this properly so if this happens, for example when the platform denies
> > PCIe tunneling, we just fail the whole negotiation and revert back to
> > what the Thunderbolt driver is doing to figure out whether the
> > controller is running firmware connection manager or not. However, we
> > should honor what the platform returns.
> >
> > For this reason run the USB4 _OSC() first with query bit set, and then
> > use the returned control double word (that may contain some of the bits
> > cleared by the platform) and run it second time with query bit clear.
> >
> > While there, remove an extra space from the assignment of the control
> > double word.
> >
> > Reported-by: NaamaX Shachar <naamax.shachar@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/acpi/bus.c | 32 +++++++++++++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index 72e64c0718c9..569bd15f211b 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -408,7 +408,7 @@ static void acpi_bus_decode_usb_osc(const char *msg, u32 bits)
> >  static u8 sb_usb_uuid_str[] = "23A0D13A-26AB-486C-9C5F-0FFA525A575A";
> >  static void acpi_bus_osc_negotiate_usb_control(void)
> >  {
> > -       u32 capbuf[3];
> > +       u32 capbuf[3], *capbuf_ret;
> >         struct acpi_osc_context context = {
> >                 .uuid_str = sb_usb_uuid_str,
> >                 .rev = 1,
> > @@ -428,7 +428,12 @@ static void acpi_bus_osc_negotiate_usb_control(void)
> >         control = OSC_USB_USB3_TUNNELING | OSC_USB_DP_TUNNELING |
> >                   OSC_USB_PCIE_TUNNELING | OSC_USB_XDOMAIN;
> >
> > -       capbuf[OSC_QUERY_DWORD] = 0;
> > +       /*
> > +        * Run _OSC first with query bit set, trying to get control over
> > +        * all tunneling. The platform can then clear out bits in the
> > +        * control dword that it does not want to grant to the OS.
> > +        */
> > +       capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
> >         capbuf[OSC_SUPPORT_DWORD] = 0;
> >         capbuf[OSC_CONTROL_DWORD] = control;
> >
> > @@ -441,8 +446,29 @@ static void acpi_bus_osc_negotiate_usb_control(void)
> >                 goto out_free;
> >         }
> >
> > +       /*
> > +        * Run _OSC again now with query bit clear and the control dword
> > +        * matching what the platform granted (which may not have all
> > +        * the control bits set).
> > +        */
> > +       capbuf_ret = context.ret.pointer;
> > +
> > +       capbuf[OSC_QUERY_DWORD] = 0;
> > +       capbuf[OSC_CONTROL_DWORD] = capbuf_ret[OSC_CONTROL_DWORD];
> > +
> > +       kfree(context.ret.pointer);
> > +
> > +       status = acpi_run_osc(handle, &context);
> > +       if (ACPI_FAILURE(status))
> > +               return;
> > +
> > +       if (context.ret.length != sizeof(capbuf)) {
> > +               pr_info("USB4 _OSC: returned invalid length buffer\n");
> > +               goto out_free;
> > +       }
> > +
> >         osc_sb_native_usb4_control =
> > -               control &  acpi_osc_ctx_get_pci_control(&context);
> > +               control & acpi_osc_ctx_get_pci_control(&context);
> >
> >         acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
> >         acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
> > --
> 
> Applied as 6.8 material, but if you want me to push this for 6.7-rc,
> please let me know (in which case it would be nice to have a Fixes:
> tag to put on it).

Thanks! I think v6.8 is fine.

