Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F845C777
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 15:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353781AbhKXOgZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 09:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356076AbhKXOgU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2021 09:36:20 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5819DC1A3AFD
        for <linux-acpi@vger.kernel.org>; Wed, 24 Nov 2021 05:24:35 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a24so1731708qvb.5
        for <linux-acpi@vger.kernel.org>; Wed, 24 Nov 2021 05:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gwPH09rM2GWYkBSfOSr8IGzqAcazRcJHuH+D3uX2xoU=;
        b=dIRaSxlCPumfgovsGN1U/L2exRS45Hq1Tuusx8dfZA4odPXNoJxzEa5YBWGl2jmwnb
         hOu3Iti4QZDOIc4wNBo1XNDx/ojblYSi/OpbfgDg7X15n1fFcF0NcdE2+wo3OVBDD4EQ
         Y/HfGQWcGZbHxyJgaDdyCJnj/2pRVi+1uMOYYg3Viys4VO03vZZn9YhsmoioZSB/cd9u
         cd97uW7AqB5DVYgz78RhIe+aOwmhDVgsZaLvKVMImRDnQP9ZJkMTGIR7CC7I9fgMsy5O
         rstPUA4S5ZNbwzxIAIppEqIldcAYlosoGF7mpHaeHYPPMdhxbbjFFGjLHdEtWXJ6zTcF
         s9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gwPH09rM2GWYkBSfOSr8IGzqAcazRcJHuH+D3uX2xoU=;
        b=TkOr6g6iar3B0uuin8zNtX3UNB0gfCf4rRHIj5Ll3q9yS6inEK0hydqpETx56AFciz
         K/MIhMYbQs0+eSZJqvOxI/rescRnA8n/90wK04RyxHWAnSJXp2IBNje/6wZaQK1F/RTy
         SWMfHuUIh+jHBAvW0aCmtl55U5udP6eHBsmyR3JDtvhCEMBZWAzPt2bc1ypngfR1qLe0
         VTvsKlZT0c5UbJ8yBZVFHDk/bVeuSyNuSGV0R4WQxbMf9+8/7npmqHS2L4OY70/bO8ZF
         yC5yo4mhf21Cq9od7qzs4h/78tmEN0/QhrScYN/nUplRzjzlOBlQXy+dMpz9m8D0ZeS8
         Ev9Q==
X-Gm-Message-State: AOAM532F70nT9HmdzWncfkytRfyrpj1Knko9T2hFJRRz2yH5NUjk6GG6
        wYhlz6TJzOKlGzK3ten7a7rKBDNLXZ3avTjd8PG+EgbDvA2FeUH7Obc=
X-Google-Smtp-Source: ABdhPJwVtMVz34XSuGe1PoJo7J7XDmp2EShjp3A7mJtLV37IsRAlX3a2sVU4WSAAkHSdrh20KQ4OEw5QIid+2E52o1k=
X-Received: by 2002:a05:6a00:1409:b0:4a7:e94c:9309 with SMTP id
 l9-20020a056a00140900b004a7e94c9309mr530633pfu.40.1637760264307; Wed, 24 Nov
 2021 05:24:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:e513:0:0:0:0 with HTTP; Wed, 24 Nov 2021 05:24:23
 -0800 (PST)
Reply-To: wu.wicusofficetg@gmail.com
From:   Western Union <efccofficetg.org@gmail.com>
Date:   Wed, 24 Nov 2021 05:24:23 -0800
Message-ID: <CAMQLAW3xYehqvLTbSTbT8Fv-LD6-q4FhJGaBxU7nc+h6hWsCZg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello, This is Mrs. Elaine Sonia Johnson of Western Union, We sent an
Email a few days back notifying you that your compensation payment has
been approved and ready for payout. Get back to us for more
clarification.
