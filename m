Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00535658C5
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Jul 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiGDOg6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Jul 2022 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiGDOg5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2022 10:36:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F15AE5A;
        Mon,  4 Jul 2022 07:36:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d5so8691947plo.12;
        Mon, 04 Jul 2022 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=7KxmduLl9TT6f15/J/PDQ9/IN0k99jvPKZFbcZ7+1fU=;
        b=KLRsdZHt1knmZDc/bHaPXEiex77NSjVfbWeYUQf3UTphb7Jve1HuNQu74Xnve3/BcM
         ZxKWJHewXRMjFXi7f0MWETUH775lz4vyxfzyOLSxQL4P3UjuEF0//zGvK744l1IH47lP
         Wlb8CG6vOf5CCKxVTLvsu+ZKSaGKH+QJ/M/FMcCR8sCdut9SM9zDyuZvyHFJT6ZWR9kW
         0daHmkW+gN72rUza4vQ0nrr4wmQvEjltNR49hJsOyTg/B6l2jO6RtW/P5NSO2voCI4Ia
         ma+MyVSDy83OkshgX47I5L9yFb4sBujNqayhg7AK0n7JEfPRSZWffR3loyOdYlm6tJuu
         xa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7KxmduLl9TT6f15/J/PDQ9/IN0k99jvPKZFbcZ7+1fU=;
        b=LGtiEUGivm6EucXyWbnunqyd04szH2fVdXEAqSQe6HZgaI5tO6uOz31AzvOaV2eWit
         PQmTiaBeDp+ArIrfFTEc8Q6CkPRYe8LfcdDceCI8ed9FxZvX8dpCo1HN+jPRjiHXlQLN
         xczphGULxky5hMSTBgB7HSX35A7Ge37+RASxDeWa/RmE0GhoX9bBxa++/YTd8gptkV4b
         GwAfphzEhrk9loQhwn1drLMgnuMF+2BIsgAz6U/bHaeqJNFC6gD4bU6lUdpjjdf2z22t
         lS1G+SNoSXpR9jfledhntm+OWPq1knp8w0MkdAd+EAeoLRneBoV6OQouTum1oVRCmLjO
         zdCg==
X-Gm-Message-State: AJIora8XaFlcCdfnOusBWVfLOusgChuM4XhqhCJoFsnrckUlh+7smmOw
        Ovnhsr8kzhe6XjpLZy3tp1+JLDEudm8dP1DsqbsPMAOwUc3gDg==
X-Google-Smtp-Source: AGRyM1tIvSdxnQTi76OrcTZvhnnQa07r3JgF+bcbssPpDTAEh0s89KbU3QwmU+FsoFEptjztsRLLsDzVhZ2w1Uiepw4=
X-Received: by 2002:a17:90a:e384:b0:1ec:9ef5:8704 with SMTP id
 b4-20020a17090ae38400b001ec9ef58704mr36049001pjz.125.1656945416162; Mon, 04
 Jul 2022 07:36:56 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Natalsson <harmoniesworlds@gmail.com>
Date:   Mon, 4 Jul 2022 17:36:44 +0300
Message-ID: <CADs9LoN7mvP0MV1NheXsBVoXYDNc5S-qNK6CLNUiOqRasuNVJQ@mail.gmail.com>
Subject: System is very slow after resume on Amlogic A311D
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f1940e05e2fbaa50"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--000000000000f1940e05e2fbaa50
Content-Type: text/plain; charset="UTF-8"

Hello friends!
I using the Khadas VIM3 SBC with Amlogic A311D device.
When I resuming after "echo mem > /sys/power/state" my system is very
and very slow, more than 5 times slowing.
CPU frequensies throght sysfs are similars for before suspend and after resume
VIM3 ~ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
1800000
VIM3 ~ # cat /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
2208000
VIM3 ~ # echo mem > /sys/power/state
VIM3 ~ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
1800000
VIM3 ~ # cat /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
2208000
VIM3 ~ #

However in uart console log I recieve such message:

bl30 get wakeup sources!
process command 00000006
bl30 enter suspend!
Little core clk suspend rate 1800000000
Big core clk suspend rate 24000000
store restore gp0 pll
suspend_counter: 1
Enter ddr suspend
DMC_DRAM_STAT11: 0x544
ddr suspend time: 2177us
alarm=0S
process command 00000001
cec ver:2018/04/29
CEC cfg:0x0000
use vddee new table!
use vddee new table!
exit_reason:0x06
Enter ddr resume
DMC_DRAM_STAT3: 0x544
ddr resume time: 3187us
store restore gp0 pll
cfg15 3b00000
cfg15 63b00000
Little core clk resume rate 1800000000
Big core clk resume rate 50000000
login: timed out after 60 seconds
Arch Linux 5.19.0-rc2-ARCH+ (ttyAML0)
VIM3 login:

I'm not sure, but I think what the  "Big core clk resume rate too
small  for Amlogic A311D and therefore my system is very slow.
Is there any way to fix this?

--000000000000f1940e05e2fbaa50
Content-Type: application/octet-stream; name=sysbench_before_suspend
Content-Disposition: attachment; filename=sysbench_before_suspend
Content-Transfer-Encoding: base64
Content-ID: <f_l56ui5qo1>
X-Attachment-Id: f_l56ui5qo1

bGVoYUBWSU0zIH4vQXJjaGxpbnV4VklNL2xpbnV4LWdpdC1zdXNwZW5kICQgc3lzYmVuY2ggY3B1
IC0tdGhyZWFkcz0xMCBydW4Kc3lzYmVuY2ggMS4wLjIwICh1c2luZyBzeXN0ZW0gTHVhSklUIDIu
MS4wLWJldGEzKQoKUnVubmluZyB0aGUgdGVzdCB3aXRoIGZvbGxvd2luZyBvcHRpb25zOgpOdW1i
ZXIgb2YgdGhyZWFkczogMTAKSW5pdGlhbGl6aW5nIHJhbmRvbSBudW1iZXIgZ2VuZXJhdG9yIGZy
b20gY3VycmVudCB0aW1lCgoKUHJpbWUgbnVtYmVycyBsaW1pdDogMTAwMDAKCkluaXRpYWxpemlu
ZyB3b3JrZXIgdGhyZWFkcy4uLgoKVGhyZWFkcyBzdGFydGVkIQoKQ1BVIHNwZWVkOgogICAgZXZl
bnRzIHBlciBzZWNvbmQ6IDEwMTY2LjYxCgpHZW5lcmFsIHN0YXRpc3RpY3M6CiAgICB0b3RhbCB0
aW1lOiAgICAgICAgICAgICAgICAgICAgICAgICAgMTAuMDAwOHMKICAgIHRvdGFsIG51bWJlciBv
ZiBldmVudHM6ICAgICAgICAgICAgICAxMDE3MTQKCkxhdGVuY3kgKG1zKToKICAgICAgICAgbWlu
OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAuNDcKICAgICAgICAgYXZnOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAuOTgKICAgICAgICAgbWF4OiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMzQuMzYKICAgICAgICAgOTV0aCBwZXJjZW50
aWxlOiAgICAgICAgICAgICAgICAgICAgICAgIDEuMTIKICAgICAgICAgc3VtOiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOTk4MTIuODIKClRocmVhZHMgZmFpcm5lc3M6CiAgICBldmVu
dHMgKGF2Zy9zdGRkZXYpOiAgICAgICAgICAgMTAxNzEuNDAwMC82NTYuNDUKICAgIGV4ZWN1dGlv
biB0aW1lIChhdmcvc3RkZGV2KTogICA5Ljk4MTMvMC4wMQoK
--000000000000f1940e05e2fbaa50
Content-Type: text/x-log; charset="US-ASCII"; name="dmesg.log"
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: base64
Content-ID: <f_l56ui5ld0>
X-Attachment-Id: f_l56ui5ld0

WzE3NTA3Ny44NTQxNjFdIFBNOiBzdXNwZW5kIGVudHJ5IChkZWVwKQpbMTc1MDc4LjMwNzcxOV0g
RmlsZXN5c3RlbXMgc3luYzogMC40NTMgc2Vjb25kcwpbMTc1MDc4LjMzOTY2M10gRnJlZXppbmcg
dXNlciBzcGFjZSBwcm9jZXNzZXMgLi4uIChlbGFwc2VkIDAuMDU2IHNlY29uZHMpIGRvbmUuClsx
NzUwNzguMzk2MTM0XSBPT00ga2lsbGVyIGRpc2FibGVkLgpbMTc1MDc4LjM5NjEzNl0gRnJlZXpp
bmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyAuLi4gKGVsYXBzZWQgMC4wMDEgc2Vjb25kcykg
ZG9uZS4KWzE3NTA3OC4zOTczNjFdIHByaW50azogU3VzcGVuZGluZyBjb25zb2xlKHMpICh1c2Ug
bm9fY29uc29sZV9zdXNwZW5kIHRvIGRlYnVnKQpbMTc1MDc4LjUwMzkyNl0gd2xhbjA6IGRlYXV0
aGVudGljYXRpbmcgZnJvbSAwYzozNzpkYzpkMTpmMjpiOCBieSBsb2NhbCBjaG9pY2UgKFJlYXNv
bjogMz1ERUFVVEhfTEVBVklORykKWzE3NTA3OC41MjY1ODRdIHNkIDA6MDowOjA6IFtzZGFdIFN5
bmNocm9uaXppbmcgU0NTSSBjYWNoZQpbMTc1MDc4LjU5MDAzOF0gUE06IHN1c3BlbmQgZGV2aWNl
cyB0b29rIDAuMDg2IHNlY29uZHMKWzE3NTA3OC41OTA4NDBdIERpc2FibGluZyBub24tYm9vdCBD
UFVzIC4uLgpbMTc1MDc4LjU5MjQ4M10gcHNjaTogQ1BVMSBraWxsZWQgKHBvbGxlZCAxIG1zKQpb
MTc1MDc4LjU5MzU2Nl0gcHNjaTogQ1BVMiBraWxsZWQgKHBvbGxlZCAxIG1zKQpbMTc1MDc4LjU5
NTIwMF0gcHNjaTogQ1BVMyBraWxsZWQgKHBvbGxlZCAxIG1zKQpbMTc1MDc4LjU5NzA1NF0gcHNj
aTogQ1BVNCBraWxsZWQgKHBvbGxlZCAxIG1zKQpbMTc1MDc4LjU5ODYzOV0gcHNjaTogQ1BVNSBr
aWxsZWQgKHBvbGxlZCAxIG1zKQpbMTc1MDc4LjU5OTYwMl0gRW5hYmxpbmcgbm9uLWJvb3QgQ1BV
cyAuLi4KWzE3NTA3OC42MDAwMDFdIERldGVjdGVkIFZJUFQgSS1jYWNoZSBvbiBDUFUxClsxNzUw
NzguNjAwMDU1XSBDUFUxOiBCb290ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwMDAwMDEg
WzB4NDEwZmQwMzRdClsxNzUwNzguNjAwNDY3XSBDUFUxIGlzIHVwClsxNzUwNzguNjAxMzE5XSBE
ZXRlY3RlZCBWSVBUIEktY2FjaGUgb24gQ1BVMgpbMTc1MDc4LjYwMTM3MF0gYXJjaF90aW1lcjog
Q1BVMjogVHJhcHBpbmcgQ05UVkNUIGFjY2VzcwpbMTc1MDc4LjYwMTM4NF0gQ1BVMjogQm9vdGVk
IHNlY29uZGFyeSBwcm9jZXNzb3IgMHgwMDAwMDAwMTAwIFsweDQxMGZkMDkyXQpbMTc1MDc4LjYw
MTkzMl0gQ1BVMiBpcyB1cApbMTc1MDc4LjYwMjU4M10gRGV0ZWN0ZWQgVklQVCBJLWNhY2hlIG9u
IENQVTMKWzE3NTA3OC42MDI1OTZdIGFyY2hfdGltZXI6IENQVTM6IFRyYXBwaW5nIENOVFZDVCBh
Y2Nlc3MKWzE3NTA3OC42MDI2MDBdIENQVTM6IEJvb3RlZCBzZWNvbmRhcnkgcHJvY2Vzc29yIDB4
MDAwMDAwMDEwMSBbMHg0MTBmZDA5Ml0KWzE3NTA3OC42MDI3NzddIENQVTMgaXMgdXAKWzE3NTA3
OC42MDMwMzFdIERldGVjdGVkIFZJUFQgSS1jYWNoZSBvbiBDUFU0ClsxNzUwNzguNjAzMDQ1XSBh
cmNoX3RpbWVyOiBDUFU0OiBUcmFwcGluZyBDTlRWQ1QgYWNjZXNzClsxNzUwNzguNjAzMDQ5XSBD
UFU0OiBCb290ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwMDAxMDIgWzB4NDEwZmQwOTJd
ClsxNzUwNzguNjAzMjQwXSBDUFU0IGlzIHVwClsxNzUwNzguNjAzNDkxXSBEZXRlY3RlZCBWSVBU
IEktY2FjaGUgb24gQ1BVNQpbMTc1MDc4LjYwMzUwNV0gYXJjaF90aW1lcjogQ1BVNTogVHJhcHBp
bmcgQ05UVkNUIGFjY2VzcwpbMTc1MDc4LjYwMzUwOV0gQ1BVNTogQm9vdGVkIHNlY29uZGFyeSBw
cm9jZXNzb3IgMHgwMDAwMDAwMTAzIFsweDQxMGZkMDkyXQpbMTc1MDc4LjYwMzcwM10gQ1BVNSBp
cyB1cApbMTc1MDc4LjYwNTc5OF0gbWVzb244Yi1kd21hYyBmZjNmMDAwMC5ldGhlcm5ldCBldGgw
OiBjb25maWd1cmluZyBmb3IgcGh5L3JnbWlpIGxpbmsgbW9kZQpbMTc1MDc4LjYzODQ4N10gbWVz
b244Yi1kd21hYyBmZjNmMDAwMC5ldGhlcm5ldCBldGgwOiBObyBTYWZldHkgRmVhdHVyZXMgc3Vw
cG9ydCBmb3VuZApbMTc1MDc4LjYzODU2M10gbWVzb244Yi1kd21hYyBmZjNmMDAwMC5ldGhlcm5l
dCBldGgwOiBQVFAgbm90IHN1cHBvcnRlZCBieSBIVwpbMTc1MDc4LjY4MTA0N10geGhjaS1oY2Qg
eGhjaS1oY2QuMi5hdXRvOiB4SEMgZXJyb3IgaW4gcmVzdW1lLCBVU0JTVFMgMHg0MTEsIFJlaW5p
dApbMTc1MDc4LjY4MTIxNV0gdXNiIHVzYjE6IHJvb3QgaHViIGxvc3QgcG93ZXIgb3Igd2FzIHJl
c2V0ClsxNzUwNzguNjgxMjkyXSB1c2IgdXNiMjogcm9vdCBodWIgbG9zdCBwb3dlciBvciB3YXMg
cmVzZXQKWzE3NTA3OC45NzcwMzZdIHVzYiAxLTE6IHJlc2V0IGhpZ2gtc3BlZWQgVVNCIGRldmlj
ZSBudW1iZXIgMiB1c2luZyB4aGNpLWhjZApbMTc1MDc5LjIzOTg5NF0gdXNiIDItMTogcmVzZXQg
U3VwZXJTcGVlZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIHhoY2ktaGNkClsxNzUwNzkuNDQy
OTc4XSB1c2IgMS0xLjI6IHJlc2V0IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMyB1c2lu
ZyB4aGNpLWhjZApbMTc1MDgwLjAzODAzM10gdXNiIDEtMS4yLjI6IHJlc2V0IGxvdy1zcGVlZCBV
U0IgZGV2aWNlIG51bWJlciA0IHVzaW5nIHhoY2ktaGNkClsxNzUwODAuMzc4MzQyXSB1c2IgMS0x
LjIuMzogcmVzZXQgaGlnaC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciA1IHVzaW5nIHhoY2ktaGNk
ClsxNzUwODAuNDY4Nzk0XSBtdDc2MDF1IDEtMS4yLjM6MS4wOiBGaXJtd2FyZSBWZXJzaW9uOiAw
LjEuMDAgQnVpbGQ6IDc2NDAgQnVpbGQgdGltZTogMjAxMzAyMDUyMTQ2X19fXwpbMTc1MDgwLjUy
MTQ1Nl0gdXNiIDEtMS4yLjQ6IHJlc2V0IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMTUg
dXNpbmcgeGhjaS1oY2QKWzE3NTA4MC44MjE0OThdIG10NzYwMXUgMS0xLjIuMzoxLjA6IEVycm9y
OiBNQ1UgcmVzcG9uc2UgcHJlLWNvbXBsZXRlZCEKWzE3NTA4MC44ODM5ODddIG10NzYwMXUgMS0x
LjIuMzoxLjA6IEVFUFJPTSB2ZXI6MGMgZmFlOjAwClsxNzUwODEuMjM3OTA2XSBQTTogcmVzdW1l
IGRldmljZXMgdG9vayAyLjYzMiBzZWNvbmRzClsxNzUwODEuMzQzMTIxXSBPT00ga2lsbGVyIGVu
YWJsZWQuClsxNzUwODEuMzQzMTQzXSBSZXN0YXJ0aW5nIHRhc2tzIC4uLiBkb25lLgpbMTc1MDgx
LjM2MjM5M10gcmFuZG9tOiBjcm5nIHJlc2VlZGVkIG9uIHN5c3RlbSByZXN1bXB0aW9uClsxNzUw
ODEuMzg1Mzc1XSBQTTogc3VzcGVuZCBleGl0ClsxNzUwODYuMTYxNzI2XSB3bGFuMDogYXV0aGVu
dGljYXRlIHdpdGggMGM6Mzc6ZGM6ZDE6ZjI6YjgKWzE3NTA4Ni4xNjI0NjldIHdsYW4wOiBiYWQg
VkhUIGNhcGFiaWxpdGllcywgZGlzYWJsaW5nIFZIVApbMTc1MDg2LjE4Nzc1MF0gd2xhbjA6IHNl
bmQgYXV0aCB0byAwYzozNzpkYzpkMTpmMjpiOCAodHJ5IDEvMykKWzE3NTA4Ni4yMDA0OTldIHds
YW4wOiBhdXRoZW50aWNhdGVkClsxNzUwODYuMjA1Njc1XSB3bGFuMDogYXNzb2NpYXRlIHdpdGgg
MGM6Mzc6ZGM6ZDE6ZjI6YjggKHRyeSAxLzMpClsxNzUwODYuMjExNzgzXSB3bGFuMDogUlggQXNz
b2NSZXNwIGZyb20gMGM6Mzc6ZGM6ZDE6ZjI6YjggKGNhcGFiPTB4NDExIHN0YXR1cz0wIGFpZD0x
KQpbMTc1MDg2LjI3Mzc4MV0gd2xhbjA6IGFzc29jaWF0ZWQKWzE3NTE3OC40OTI2NjVdIGlucHV0
OiBCVDUuMiBNb3VzZSBhcyAvZGV2aWNlcy92aXJ0dWFsL21pc2MvdWhpZC8wMDA1OjEyMzU6QUEy
Mi4wMDFCL2lucHV0L2lucHV0MzAKWzE3NTE3OC41MzcyMzldIGhpZC1nZW5lcmljIDAwMDU6MTIz
NTpBQTIyLjAwMUI6IGlucHV0LGhpZHJhdzM6IEJMVUVUT09USCBISUQgdjAuMDEgTW91c2UgW0JU
NS4yIE1vdXNlXSBvbiBkNDo5YzpkZDpkOTpjNTo4NQo=
--000000000000f1940e05e2fbaa50
Content-Type: application/octet-stream; name=sysbench_after_resume
Content-Disposition: attachment; filename=sysbench_after_resume
Content-Transfer-Encoding: base64
Content-ID: <f_l56ui5r72>
X-Attachment-Id: f_l56ui5r72

bGVoYUBWSU0zIH4vQXJjaGxpbnV4VklNL2xpbnV4LWdpdC1zdXNwZW5kICQgc3lzYmVuY2ggY3B1
IC0tdGhyZWFkcz0xMCBydW4gCnN5c2JlbmNoIDEuMC4yMCAodXNpbmcgc3lzdGVtIEx1YUpJVCAy
LjEuMC1iZXRhMykKClJ1bm5pbmcgdGhlIHRlc3Qgd2l0aCBmb2xsb3dpbmcgb3B0aW9uczoKTnVt
YmVyIG9mIHRocmVhZHM6IDEwCkluaXRpYWxpemluZyByYW5kb20gbnVtYmVyIGdlbmVyYXRvciBm
cm9tIGN1cnJlbnQgdGltZQoKClByaW1lIG51bWJlcnMgbGltaXQ6IDEwMDAwCgpJbml0aWFsaXpp
bmcgd29ya2VyIHRocmVhZHMuLi4KClRocmVhZHMgc3RhcnRlZCEKCkNQVSBzcGVlZDoKICAgIGV2
ZW50cyBwZXIgc2Vjb25kOiAgMTg4OS42OAoKR2VuZXJhbCBzdGF0aXN0aWNzOgogICAgdG90YWwg
dGltZTogICAgICAgICAgICAgICAgICAgICAgICAgIDEwLjAyNzZzCiAgICB0b3RhbCBudW1iZXIg
b2YgZXZlbnRzOiAgICAgICAgICAgICAgMTkwMzYKCkxhdGVuY3kgKG1zKToKICAgICAgICAgbWlu
OiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEuMTEKICAgICAgICAgYXZnOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUuMjQKICAgICAgICAgbWF4OiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMzYuMTUKICAgICAgICAgOTV0aCBwZXJjZW50
aWxlOiAgICAgICAgICAgICAgICAgICAgICAgNDIuNjEKICAgICAgICAgc3VtOiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOTk3NjQuNjIKClRocmVhZHMgZmFpcm5lc3M6CiAgICBldmVu
dHMgKGF2Zy9zdGRkZXYpOiAgICAgICAgICAgMTkwMy42MDAwLzI0NjguMjUKICAgIGV4ZWN1dGlv
biB0aW1lIChhdmcvc3RkZGV2KTogICA5Ljk3NjUvMC4wMQoKbGVoYUBWSU0zIH4vQXJjaGxpbnV4
VklNL2xpbnV4LWdpdC1zdXNwZW5kICQgCgo=
--000000000000f1940e05e2fbaa50--
