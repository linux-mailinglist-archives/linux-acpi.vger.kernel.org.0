Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369EF35A58
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2019 12:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfFEKPy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jun 2019 06:15:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:40198 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfFEKPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Jun 2019 06:15:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 03:15:41 -0700
X-ExtLoop1: 1
Received: from pbooyens-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.48.29])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jun 2019 03:15:40 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 5920B21D78; Wed,  5 Jun 2019 13:15:36 +0300 (EEST)
Date:   Wed, 5 Jun 2019 13:15:36 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-acpi@vger.kernel.org, rajmohan.mani@intel.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 3/5] ov5670: Support probe whilst the device is off
Message-ID: <20190605101535.4sydewuv656x6c2g@kekkonen.localdomain>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
 <20190510100930.14641-4-sakari.ailus@linux.intel.com>
 <20190605070752.GA126683@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605070752.GA126683@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Tomasz,

On Wed, Jun 05, 2019 at 04:07:52PM +0900, Tomasz Figa wrote:
> Hi Sakari,
> 
> On Fri, May 10, 2019 at 01:09:28PM +0300, Sakari Ailus wrote:
> > Tell ACPI device PM code that the driver supports the device being powered
> > off when the driver's probe function is entered.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/media/i2c/ov5670.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
> > index 041fcbb4eebdf..57e8b92f90e09 100644
> > --- a/drivers/media/i2c/ov5670.c
> > +++ b/drivers/media/i2c/ov5670.c
> > @@ -2444,6 +2444,7 @@ static int ov5670_probe(struct i2c_client *client)
> >  	struct ov5670 *ov5670;
> >  	const char *err_msg;
> >  	u32 input_clk = 0;
> > +	bool powered_off;
> >  	int ret;
> >  
> >  	device_property_read_u32(&client->dev, "clock-frequency", &input_clk);
> > @@ -2460,11 +2461,14 @@ static int ov5670_probe(struct i2c_client *client)
> >  	/* Initialize subdev */
> >  	v4l2_i2c_subdev_init(&ov5670->sd, client, &ov5670_subdev_ops);
> >  
> > -	/* Check module identity */
> > -	ret = ov5670_identify_module(ov5670);
> > -	if (ret) {
> > -		err_msg = "ov5670_identify_module() error";
> > -		goto error_print;
> > +	powered_off = acpi_dev_powered_off_for_probe(&client->dev);
> > +	if (!powered_off) {
> > +		/* Check module identity */
> > +		ret = ov5670_identify_module(ov5670);
> > +		if (ret) {
> > +			err_msg = "ov5670_identify_module() error";
> > +			goto error_print;
> > +		}
> >  	}
> 
> I don't like the fact that we can't detect any hardware connection issue
> here anymore and we would actually get some obscure failure when we
> actually start streaming.
> 
> Wouldn't it be possible to still keep this behavior of not powering on
> the device at boot-up if no driver is bound and then have this driver
> built as a module and loaded later when the camera is to be used for the
> first time after the system boots?

That'd be a way to work around this, but the downside would be that the
user space would need to know not only which drivers to load, but also
which drivers _not_ to load. The user space could obtain the former from
the kernel but not the latter, it'd be system specific configuration.

Moving the responsibility of loading the driver to user space would also
not address figuring out whether the sensor is accessible through its
control bus: you have to power it on to do that. In fact, if you want to be
sure that the hardware is all right, you have to start streaming on the
device first and that is not a part of a typical driver initialisation
sequence. Just checking the sensor is accessible over I²C is not enough.

The proposed solution addresses the problem without user space changes.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
