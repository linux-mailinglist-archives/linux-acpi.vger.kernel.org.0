Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED5709F22
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjESSet convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 19 May 2023 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjESSes (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 14:34:48 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C21A6;
        Fri, 19 May 2023 11:34:47 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96f72e6925cso19151966b.1;
        Fri, 19 May 2023 11:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684521286; x=1687113286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uObuVqlcM50D70QQIhJEH6f7OXBSEmcDsqgtzVm67w=;
        b=LrUhFNQ46y3ebupRr9pSsJzC1Fzj10J9S2d8/ZLyA436cpmo94tQvjKamRGnyOUUOO
         M3vlR8UPB5dKgEpz//2LRSBpTuPVwIYk5iT2qMJY2CsaLm5EO7VZ1PuM81hujmam3ytG
         8Gv0AIXIHAFHcTw+2o/7FclgmhrRUsYc//erhR5cIsSonKXoIhG94zY/otnJCOMDKe9Q
         F2sAGk0QwfXVzO+ZNAWTwmnnYfcFZdu3gE0L087zd9C2BRqzJmoHz/5TIol4m3ZLG7E6
         nVFQlW2G1Nj7NYcOtQIyPMx92Q3xlCtMBg/h4P8j2SV6oVhFS2Dxn3qDbqYeoz5Ov420
         6btg==
X-Gm-Message-State: AC+VfDxq7mmmrNwpT/Uo9nJHW9CpPfgCDEB3CoMZee/A0h9sEu2GDFX/
        09Nf/zEV6WtDV1d3aUu5w/xYFwdqtVNWY0CbRKIdII7u
X-Google-Smtp-Source: ACHHUZ5vuEiTa1HNW/9/UzjDodQ47QYiuPqoHSQtfLrZdi87rUPkWVbmgaLHaTnrSSbc9KwkLjj1tGfNHxLGEvlPoLs=
X-Received: by 2002:a17:906:212:b0:94f:4ec3:f0f5 with SMTP id
 18-20020a170906021200b0094f4ec3f0f5mr2941090ejd.4.1684521285520; Fri, 19 May
 2023 11:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com> <20230329100951.1522322-9-sakari.ailus@linux.intel.com>
In-Reply-To: <20230329100951.1522322-9-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 May 2023 20:34:34 +0200
Message-ID: <CAJZ5v0gFeN7WQQStjP80jdCM-yi2vaa9vyh-Smp9jOfjfv3wAA@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] ACPI: property: Rename parsed MIPI DisCo for
 Imaging properties
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> MIPI DisCo for Imaging defines properties for sensor-adjacent devices such
> as EEPROM, LED flash or lens VCM as either device or sub-node references.
> This is compliant with existing DT definitions apart from property names.
>
> Rename parsed MIPI-defined properties so drivers will have a unified view
> of them as defined in DT and already parsed by drivers.

I don't particularly like this idea.

One of the drawbacks is that if somebody doesn't care about DT
bindings (for instance, because they will always run on platforms
without DT), they won't be able to use the MIPI-defined property names
in their code.

I would very much prefer to add a set of DT-defined properties with
the same values.  The, whoever wants to use the property names from
the DT bindings, they will be able to do that, but it will be also
possible to use the MIPI-defined ones.

The previous patch adds the "rotation" property to the swnodes set, so
I don't see any problems with doing that for the properties in
question.
