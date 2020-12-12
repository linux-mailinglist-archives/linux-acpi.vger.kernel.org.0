Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F22D83F1
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Dec 2020 03:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395363AbgLLCMf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 21:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgLLCMR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 21:12:17 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF3C0613CF
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2020 18:11:31 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id k78so9833643ybf.12
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2020 18:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=67MWdI7KvvifJxBjiceZWcTSzEXiHkH7JT5vLxlwZF8=;
        b=qdhV7BJWcvbt8Jjykm35ptCBKrdr2Np5KRT2ECaOud+agNz5yffWcB/tV6ecpT9EhW
         1zDMwReje17vg1md0+dX2QapuxKdCEcHzcUpzHtJmcAvKTVU9huK94c7kEVaKiK64TZx
         20/0c84H4GLrjLoyYguomhqGku4XZqKX8eySW/xmrN1FkKWGgSxMcY9QjFrpfzTl9OyA
         sXC5I7PAvRD07lrKkUVxN7smrV2QmLoCf9huBpx5EBUMn3as9weY1VV9IW3FgHc1BzIU
         Oprsfdtu9BkFfpBx0Y18ZvUvHeqlh+p9zrqtJ05Gd7sWzG9QAFRWe1/dnzAoUyWFUDzl
         o41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=67MWdI7KvvifJxBjiceZWcTSzEXiHkH7JT5vLxlwZF8=;
        b=KhdAuc5V4acwRcJVeZzHytnpjw09RatOX5bKh1Isn183b2ywHp1inkjW0LN3F4J8vv
         vPMH2JLSVMPOs2d+8pgmbuNa5M0BFHsKZMUJyTHXqyHeUfMHKHAkRB8FnZOJJ80er86P
         0IeXMbxcyuDrTxkP6Gg0/7bzIyPcZkZdnfCQI5eJ+wbd4Vsonh79LpccyYmSSBBo2Xqb
         Iaai8L7bmxm2/eSj6tVlMfPuXNbLXTRA6m7oNgv9CSzKOnLe33Y4Sqsu3pxLuwObklnm
         AKtsGAk2OikvUp1KUtu3yUflJLSUrMS4jDRxWX0S5IZUMnDezCAygEZzoNwRqfcSy6+6
         iwpA==
X-Gm-Message-State: AOAM532Wm5NgPhvQTusHbkiZpPuPwrBKU/qOdMLKxBmJwNznJRvSa5td
        5o+aLYUbg2gK/N+HmrvC84HFN0HcMOKD5Ft8Ht4wf6ezlK7Whg==
X-Google-Smtp-Source: ABdhPJz61bnGYD302sFy1nM54Q7kmPn9QzEXB7p/9tBQ2uEtYElHEt1Tu/6YrTffm7aRe7plGINtvHPKw3QGvKu9GTw=
X-Received: by 2002:a25:824e:: with SMTP id d14mr15601272ybn.346.1607739089652;
 Fri, 11 Dec 2020 18:11:29 -0800 (PST)
MIME-Version: 1.0
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 11 Dec 2020 18:10:53 -0800
Message-ID: <CAGETcx8BmwWKAcH3vtLh=zrTEwJX_Y2nS1uB4Hq0priMQOnohQ@mail.gmail.com>
Subject: fw_devlink for ACPI - need some pointers
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi ACPI devs,

I want to take a stab at adding fw_devlink support for ACPI.

fw_devlink adds device links between consumer and supplier devices. It
finds the supplier-consumer dependencies by looking at the firmware
nodes of devices as they are added to driver core.

Main benefits of fw_devlink (because it creates device links):
* Removes a lot of deferred probes or probe failures (due to poor
error handling).
* Makes module load order less important for things to probe successfully.
* Makes suspend/resume a bit more robust.

For DT (devicetree), I know how to interpret the common properties
(Eg: clocks, -gpios, etc) to figure out what devices supply resources
for a given device. In general, I'm familiar with DT and there's also
Documentation/devicetree/bindings/ that I can grep for if I need to
know what a property means. So, I've been able to implement fw_devlink
for DT.

Now, I want to add support for ACPI to get the ball rolling. However,
I'm fairly clueless with it comes to ACPI. So, if I can get some
pointers, that'd be great!

Things I need help with:
1) I don't even know how to view the ACPI data on my PC. For example,
in DT, /sys/firmware/devicetree/ has the entire DT represented as a
tree of folders and files. How do I read ACPI info that lists all the
devices, their properties, etc?

2) Is there documentation to look up what each of those device properties mean?

3) How are some of the common device dependencies listed in ACPI? For
example, if a device depends on power, clock, GPIO, interrupt, etc how
does ACPI list the supplier devices for each of those resources?

4) Assuming there are a few common properties that list the device
dependencies, how do I look up a firmware node that a property points
to? If this is not how it works, how does it work?

In general, any pointers to docs that'll answer the above questions
would also be appreciated.

Thanks,
Saravana
