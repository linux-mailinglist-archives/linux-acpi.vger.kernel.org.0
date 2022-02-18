Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ADC4BBD64
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Feb 2022 17:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiBRQVm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Feb 2022 11:21:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238257AbiBRQVC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2022 11:21:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC062B5BBC
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 08:20:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so12766709pjv.5
        for <linux-acpi@vger.kernel.org>; Fri, 18 Feb 2022 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=c3P4r2Qz0VdfRBuStsXVpcJEgpWE5t0Sgi1SeeHIl+U=;
        b=M9hfPI138KDDt804RkGAztpDYFNssdBL19gz4g13EKh20uKmWSsHaanyhfegwt2KSk
         nfuNd2O0WbFC36RDWF+xSZLM7Dnm7tjsA32x7hNmuZO+5rTt8ofGMDqg7P7ZACm7Q7GO
         EmPuWD9B/VfeJaZ6h0Bk8yrIWVqwT1DGnhc/TxyaJrNwcsE0lqmkrPdWh3SuvF+mmvYw
         BkMo0kk94yH5QykA6xjlRQm6xD7fXF3DaaEJ5c/hqvdUf4u5OirPf4lenlVHc+ooOTxl
         hnRSW/bM8HEKPs3JC1lRCvA37qWul+UsSUpSUYc8cmXTsFGZD8yMxA4hsYoc8uQgcwAa
         YYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=c3P4r2Qz0VdfRBuStsXVpcJEgpWE5t0Sgi1SeeHIl+U=;
        b=n+aUOk5oBePlfuFrPwuECerYOXD4G2karkTPAmf6r5InDgzea84thbtjZnD8pOgFt8
         fBq9vzXXfr5KGb9xYCl/5Vn/TEZS2ZoMsunJm1YKPjx5ZJ9uGIUVdg5ethiw45iDfcTZ
         0msth97AH7W13q1ADCpNQ5aepMFZjHyl6RIxcUsvdyCpuTwEOynDbleKzGogPOqttgyi
         KwJwT7a6XY9VMZHqCR1AZNj5zKznx3b0hflEvsXncG88PoOAon9kK9BSHahbpsDSBakn
         yYA99N/YGy5OX0JrfG0NXWGjtLAI1CNLp09RsMJupbZ+6cVnzEjqNp1zrdD09UAZDTYn
         RfJg==
X-Gm-Message-State: AOAM5338K9OPSGESga9GoRCDowSMW++WJhhH+1TYjIdKrUWq3heLC6vk
        Jxq3+DJz2JB4ThdWH56cjtvPVCtc8MpVNT1ASCQ=
X-Google-Smtp-Source: ABdhPJxGSQYD4qXcFSRe7Xv2/hR++B76fvvPgMZT96Zv6exchrzXCy2RM8HFDpxqh3b76zgHhILlwdVRNcWTUuiV6zw=
X-Received: by 2002:a17:903:2042:b0:14e:e8e6:7224 with SMTP id
 q2-20020a170903204200b0014ee8e67224mr8330309pla.30.1645201219350; Fri, 18 Feb
 2022 08:20:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90b:1651:0:0:0:0 with HTTP; Fri, 18 Feb 2022 08:20:18
 -0800 (PST)
Reply-To: info.tiffanywiffany@gmail.com
From:   Tiffany Wiffany <sylviajones046@gmail.com>
Date:   Fri, 18 Feb 2022 08:20:18 -0800
Message-ID: <CAGH1ixvV_kjfmx9dveoD7ZPWfGF8by-hFvnV5hC03FnkeNeUiA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

-- 
Please with honesty did you receive our message we  send to you?
