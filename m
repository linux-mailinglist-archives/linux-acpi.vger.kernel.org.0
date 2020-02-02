Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452D214FB14
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Feb 2020 01:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBBAzW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Feb 2020 19:55:22 -0500
Received: from sonic313-14.consmr.mail.bf2.yahoo.com ([74.6.133.124]:39042
        "EHLO sonic313-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbgBBAzW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Feb 2020 19:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580604921; bh=YooljpITC31Cc9KXMfJzAPmr/1tCBEdX27fhfqn54Fs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=S5oCEhXpvsi1xMvAs1s/OI3/QquDDobJKYwG3N3GxYMB8u3EJnS8/j40DNbPxqKh7hL5p9mbxp882HGx+UpQNKuvjSIw9FYyJ8pWp2OV8XY1NDl6RmHH/ZLuQK7ktBjVtRpize55FvxvRRKNkNr4oqDn1/bUQ0v3QjY6ESLOrxLRBz58iIgmXYIWCI/4p4DCKA/Lk7gzIIawbQV/KKpeP2DVtSFi/IbleK1uCzkWxgyqZ9mLFzLCEretp47mSXlGmwoQDQ77VhlEjKq2lHb83ylPI13+00riFAL35bZDlt319X6OW2J9B0MnS4dDHHcneYMT+Muex6CfsudCktBhuw==
X-YMail-OSG: IFySW08VM1nEcMBf7jogDoRmQEPI9L9pyDL3J7J0rVSCmimlGRI.o3eRM2YpFp8
 jcKTZcQ05tjVHuFyYq_hYYkqAv.WBpTpPYhudcHQQWKwS9FpSx77GO0MVnPSH0HwMh69BC1ZdMsu
 8_o7jErVH4Rbrwki6yZcSaQtXCCJiZtvJJXoF8Pxb_8VyNf7XjO3s4ifomxdlmVOdHSo7YsvBPUH
 ZB40JWZOzL3WVqTIZKfKftLjX5Zg7cbYhuKaVY2AUz78w.rH9H_tkjitDoSwKg2a2fRXcvV83U9B
 jiGSrfGyJNRAu1fHTeslo4i9hY55jWkpRlgXFFULCKO4jPscePePuMoxkR34pZJXRMNLRkXVOiHr
 cQL_uKq5huG6V8QN_ThGLW10SovgOhVTLyg0fbpp8jDw9jrWS9h4Zqa22mrnGKixyaf.McBo0P.8
 r.HbTvms619.jNBChvMOWXGLiT_Z2RoB4sIhN4M4zexLTVYMrTKWHJcx8v0GWdPFhtf4JmkJ11ho
 .3jxOcD82pC2bxpUDEypKmENCW6g9S2MsPnUoBdA3yUJs4oRLiKkhSLf.9u62v4l1jT2xATdEYts
 PdzKYhwuYIE1sbdEjnBCD4NilODmq.3FK3qNLvM9aVhbGjQVXnRnuB2RrHXKzusX2Jnh63t_WV.b
 eI2fnSI375lP8uSbcGSC4Ul1LA.MRLIgy3J2ud8Bn1AFQiy.D_.OAoUUs0zK_gpZSptDdVLGcBh6
 FCPjhI9W2g5iGHCLw3jHzzIeWhphLgW3K2AxfDX30FQ930PAkajRCO4o_9m18ux.d_8Jg2_QP0Ld
 K_P9YnGL.VBNI5qDMn51oFuFGa4.uq6y8.dXNWKNMurNGzpaKz17bVHclEiqTtwuFcrVtO0kxZKt
 GaBQDFqHWqOXAuGKqUiPEAuN75kOPf2yIxVw6.2IRgv6KdkKhMACLQI0k00kjYP_cDV9l9G1kag2
 4N06iivjccGeCg7AVAtRc8Js0mpCVadUnbslObuE8_b3TwJpWpIVNpsY5v3CkWId1qstQGSWuWo6
 glw5DT_K4BupsSL4fS5iZvlIKo_3OB1Gfto4eTdkEjcTcIoQN3yc1cQwc9FDzatlbdxiFpZ95ibW
 Qm0haXn0nhM21y2l9vmHacsGdnraxxS8aous4VC9GROs0vDB2DYtij_1kpK2N21m8fcznKcPoRm8
 .PUF.5S0GRn3J9ejjKe9l4fFC3i2BEIM1qjNKZr8FZo1fR9OHbodrKYD9PtAchzd6zhq7h3wIU6I
 lgzfJeeb2ra7XFHHjxtCn9IqQLVpl2xRHSMwl.GaDDWKJT8DxrGF__TstA45YnGkuVW04O2I.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Feb 2020 00:55:21 +0000
Date:   Sun, 2 Feb 2020 00:55:18 +0000 (UTC)
From:   Lisa Williams <ah1195485@gmail.com>
Reply-To: lisawilliams00357@yahoo.com
Message-ID: <727789886.314862.1580604918409@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <727789886.314862.1580604918409.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15149 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



Hi Dear,

I was just going through the Internet search when I found your email address, I want to make a new and special friend, so I decided to contact you to see how we can make it work out if we can. Please I wish you will have the desire with me so that we can get to know each other better and see what happens in future.

My name is Lisa Williams, I am an American, but presently I live in the UK, I will be glad to see your reply for us to know each other better to exchange pictures and details about us

Yours
Lisa
