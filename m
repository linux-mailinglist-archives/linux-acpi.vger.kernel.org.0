Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D89DF9CBB8
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 10:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfHZIiT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 04:38:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:19956 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbfHZIiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 04:38:18 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:38:17 -0700
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="170789779"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:38:16 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 1DCBB20B47; Mon, 26 Aug 2019 11:38:14 +0300 (EEST)
Date:   Mon, 26 Aug 2019 11:38:14 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-acpi@vger.kernel.org,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH 3/5] ov5670: Support probe whilst the device is off
Message-ID: <20190826083813.GK31967@paasikivi.fi.intel.com>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
 <20190510100930.14641-4-sakari.ailus@linux.intel.com>
 <20190605070752.GA126683@chromium.org>
 <20190605101535.4sydewuv656x6c2g@kekkonen.localdomain>
 <CAAFQd5D+RZS0E6xpZ3v8gC5zerj5fd6b6YxcAS_TeWei6vGvUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFQd5D+RZS0E6xpZ3v8gC5zerj5fd6b6YxcAS_TeWei6vGvUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Tomasz,

On Fri, Jun 07, 2019 at 04:54:06PM +0900, Tomasz Figa wrote:
> On Wed, Jun 5, 2019 at 7:15 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Tomasz,
> >
> > On Wed, Jun 05, 2019 at 04:07:52PM +0900, Tomasz Figa wrote:
> > > Hi Sakari,
> > >
> > > On Fri, May 10, 2019 at 01:09:28PM +0300, Sakari Ailus wrote:
> > > > Tell ACPI device PM code that the driver supports the device being powered
> > > > off when the driver's probe function is entered.
> > > >
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/media/i2c/ov5670.c | 25 ++++++++++++++-----------
> > > >  1 file changed, 14 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
> > > > index 041fcbb4eebdf..57e8b92f90e09 100644
> > > > --- a/drivers/media/i2c/ov5670.c
> > > > +++ b/drivers/media/i2c/ov5670.c
> > > > @@ -2444,6 +2444,7 @@ static int ov5670_probe(struct i2c_client *client)
> > > >     struct ov5670 *ov5670;
> > > >     const char *err_msg;
> > > >     u32 input_clk = 0;
> > > > +   bool powered_off;
> > > >     int ret;
> > > >
> > > >     device_property_read_u32(&client->dev, "clock-frequency", &input_clk);
> > > > @@ -2460,11 +2461,14 @@ static int ov5670_probe(struct i2c_client *client)
> > > >     /* Initialize subdev */
> > > >     v4l2_i2c_subdev_init(&ov5670->sd, client, &ov5670_subdev_ops);
> > > >
> > > > -   /* Check module identity */
> > > > -   ret = ov5670_identify_module(ov5670);
> > > > -   if (ret) {
> > > > -           err_msg = "ov5670_identify_module() error";
> > > > -           goto error_print;
> > > > +   powered_off = acpi_dev_powered_off_for_probe(&client->dev);
> > > > +   if (!powered_off) {
> > > > +           /* Check module identity */
> > > > +           ret = ov5670_identify_module(ov5670);
> > > > +           if (ret) {
> > > > +                   err_msg = "ov5670_identify_module() error";
> > > > +                   goto error_print;
> > > > +           }
> > > >     }
> > >
> > > I don't like the fact that we can't detect any hardware connection issue
> > > here anymore and we would actually get some obscure failure when we
> > > actually start streaming.
> > >
> > > Wouldn't it be possible to still keep this behavior of not powering on
> > > the device at boot-up if no driver is bound and then have this driver
> > > built as a module and loaded later when the camera is to be used for the
> > > first time after the system boots?
> >
> > That'd be a way to work around this, but the downside would be that the
> > user space would need to know not only which drivers to load, but also
> > which drivers _not_ to load. The user space could obtain the former from
> > the kernel but not the latter, it'd be system specific configuration.
> >
> > Moving the responsibility of loading the driver to user space would also
> > not address figuring out whether the sensor is accessible through its
> > control bus: you have to power it on to do that. In fact, if you want to be
> > sure that the hardware is all right, you have to start streaming on the
> > device first and that is not a part of a typical driver initialisation
> > sequence. Just checking the sensor is accessible over I涎 is not enough.
> >
> > The proposed solution addresses the problem without user space changes.
> 
> I guess that makes sense indeed. If going this way, why not just move
> all the hardware access from probe to streamon and avoid any
> conditional checks at all?

My apologies for the late answer.

In that case there would be no way to verify the hardware actually is
there, even on systems where there is no adverse effect from doing that.
For a sensor driver this could be just fine, but I have doubts it'd be
appropriate for e.g. the at24 driver.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
